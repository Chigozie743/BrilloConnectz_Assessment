import 'package:brillo_connectz_assessment/constants/constant.dart';
import 'package:brillo_connectz_assessment/services/database_service.dart';
import 'package:brillo_connectz_assessment/views/buddies_screen/buddies_screen.dart';
import 'package:brillo_connectz_assessment/widgets/message_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String buddiesId;
  final String buddiesName;
  final String userName;
  const ChatScreen(
      {Key? key,
        required this.buddiesId,
        required this.buddiesName,
        required this.userName})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();
  String admin = "";

  @override
  void initState() {
    getChatandAdmin();
    super.initState();
  }

  getChatandAdmin() {
    DatabaseService().getChats(widget.buddiesId).then((val) {
      setState(() {
        chats = val;
      });
    });
    DatabaseService().getBuddiesAdmin(widget.buddiesId).then((val) {
      setState(() {
        admin = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.buddiesName),
        backgroundColor: lightScaffoldColor,
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(
                    context,
                    BuddiesScreen(
                      buddiesId: widget.buddiesId,
                      buddiesName: widget.buddiesName,
                      adminName: admin,
                    ));
              },
              icon: const Icon(Icons.info))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: <Widget>[
            // chat messages here
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[700],
                child: Row(children: [
                  TextFormField(
                    controller: messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Send a message...",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      sendMessage();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          )),
                    ),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return MessageTile(
                message: snapshot.data.docs[index]['message'],
                sender: snapshot.data.docs[index]['sender'],
                sentByMe: widget.userName ==
                    snapshot.data.docs[index]['sender']);
          },
        )
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseService().sendMessage(widget.buddiesId, chatMessageMap);
      setState(() {
        messageController.clear();
      });
    }
  }
}