import 'package:brillo_connectz_assessment/constants/constant.dart';
import 'package:brillo_connectz_assessment/helper/helper_function.dart';
import 'package:brillo_connectz_assessment/services/auth_service.dart';
import 'package:brillo_connectz_assessment/services/database_service.dart';
import 'package:brillo_connectz_assessment/views/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //var firestoreDb = FirebaseFirestore.instance.collection("profile").snapshots();

  String email = "";
  String fullName = "";
  String image = "";
  String interest = "";
  String phoneNumber = "";
  String countryDial = "+1";
  AuthService authService = AuthService();

  gettingUserData() async {
    await HelperFunctions.getUsersEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUsersNameFromSF().then((value) {
      setState(() {
        fullName = value!;
      });
    });
    await HelperFunctions.getUsersPhoneFromSF().then((value) {
      setState(() {
        phoneNumber = value!;
      });
    });
    await HelperFunctions.getUsersInterestFromSF().then((value) {
      setState(() {
        interest = value!;
      });
    });
    // getting the list of snapshots in our stream
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserBuddies()
        .then((snapshot) {
      setState(() {
        //groups = snapshot;
      });
    });
  }


  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                 backgroundImage: AssetImage("images/avatar.png"),
                  radius: 90.0,
                ),
              ),
              // PLACING A DIVIDER BETWEEN THE IMAGE AND NAME
              const Divider(
                height: 90.0,
                color: Colors.black,
              ),
              const Text(
                'NAME',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              // HEIGHT BETWEEN TWO WIDGET FOR VERTICAL DISTANCE
              const SizedBox(height: 10.0),
              Text(
                 fullName!,
                style: const TextStyle(
                  //color: Colors.amberAccent[200],
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // HEIGHT BETWEEN TWO WIDGET FOR VERTICAL DISTANCE
              const SizedBox(height: 30.0),
              const Text(
                'INTEREST',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              // HEIGHT BETWEEN TWO WIDGET FOR VERTICAL DISTANCE
              const SizedBox(height: 10.0),
              Text(
                interest!,
                style: const TextStyle(
                  //color: Colors.amberAccent[200],
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30.0,),
              Row(
                children: [
                  Icon(
                    Icons.email_rounded,
                    color: Colors.grey[400],
                  ),
                  // WIDTH BETWEEN TWO WIDGET FOR HORINZONTAL DISTANCE
                  const SizedBox(width: 10.0),
                  Text(
                    email!,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 18.0,
                      letterSpacing: 1.0,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30.0,),
              Row(
                children: [
                  Icon(
                    IconlyBold.call,
                    color: Colors.grey[400],
                  ),
                  // WIDTH BETWEEN TWO WIDGET FOR HORINZONTAL DISTANCE
                  const SizedBox(width: 10.0),
                  Text(
                    phoneNumber!,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 18.0,
                      letterSpacing: 1.0,
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
