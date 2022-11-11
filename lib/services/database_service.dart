import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //Reference for our collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference buddiesCollection =
      FirebaseFirestore.instance.collection("buddies");

  //Saving the user data
  Future savingUserData(String fullName, String email, String phoneNumber, String interest) async{
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "email": email,
      "interest": interest,
      "buddies": [],
      "profilePic": "",
      "uid": uid,
    });
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
    await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  // get user groups
  getUserBuddies() async {
    return userCollection.doc(uid).snapshots();
  }

  // creating a group
  Future createBuddies(String userName, String id, String buddiesName) async {
    DocumentReference buddiesDocumentReference = await buddiesCollection.add({
      "buddiesName": buddiesName,
      "buddiesIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "buddiesId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    // update the members
    await buddiesDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "buddiesId": buddiesDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "buddies":
      FieldValue.arrayUnion(["${buddiesDocumentReference.id}_$buddiesName"])
    });
  }

  // getting the chats
  getChats(String buddiesId) async {
    return buddiesCollection
        .doc(buddiesId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  Future getBuddiesAdmin(String buddiesId) async {
    DocumentReference d = buddiesCollection.doc(buddiesId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  // get group members
  getBuddiesMembers(buddiesId) async {
    return buddiesCollection.doc(buddiesId).snapshots();
  }

  // search
  searchByName(String buddiesName) {
    return buddiesCollection.where("buddiesName", isEqualTo: buddiesName).get();
  }

  // function -> bool
  Future<bool> isUserJoined(
      String buddiesName, String buddiesId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> buddies = await documentSnapshot['buddies'];
    if (buddies.contains("${buddiesId}_$buddiesName")) {
      return true;
    } else {
      return false;
    }
  }

  // toggling the group join/exit
  Future toggleBuddiesJoin(
      String buddiesId, String userName, String buddiesName) async {
    // doc reference
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference buddiesDocumentReference = buddiesCollection.doc(buddiesId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> buddies = await documentSnapshot['buddies'];

    // if user has our buddies -> then remove then or also in other part re join
    if (buddies.contains("${buddiesId}_$buddiesName")) {
      await userDocumentReference.update({
        "buddies": FieldValue.arrayRemove(["${buddiesId}_$buddiesName"])
      });
      await buddiesDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userDocumentReference.update({
        "buddies": FieldValue.arrayUnion(["${buddiesId}_$buddiesName"])
      });
      await buddiesDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }

  // send message
  sendMessage(String buddiesId, Map<String, dynamic> chatMessageData) async {
    buddiesCollection.doc(buddiesId).collection("messages").add(chatMessageData);
    buddiesCollection.doc(buddiesId).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });
  }

}