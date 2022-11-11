import 'package:brillo_connectz_assessment/constants/constant.dart';
import 'package:brillo_connectz_assessment/views/auth/login_screen.dart';
import 'package:brillo_connectz_assessment/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SettingAndPrivacyScreen extends StatefulWidget {
  const SettingAndPrivacyScreen({Key? key}) : super(key: key);

  @override
  State<SettingAndPrivacyScreen> createState() => _SettingAndPrivacyScreenState();
}

class _SettingAndPrivacyScreenState extends State<SettingAndPrivacyScreen> {
  TextEditingController nameInputController = TextEditingController();
  TextEditingController interestInputController = TextEditingController();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController phoneInputController = TextEditingController();

  String email = "";
  String fullName = "";
  String interest = "";
  String phoneNumber = "";
  String countryDial = "+1";

  @override
  void initState() {
    // TODO: implement initState
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting and Privacy"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(context, const LoginScreen());
              },
              icon: Icon(
                IconlyBold.logout,
                color: lightFocusedColor,
              )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  labelText: "Full Name",
                  prefixIcon: Icon(Icons.person, color: lightIconsColor,),
                ),
                onChanged: (value) {
                  setState(() {
                    fullName = value;
                  });
                },
                controller: nameInputController,
              ),

              const SizedBox(height: 15.0,),

              TextFormField(
                decoration: textInputDecoration.copyWith(
                  labelText: "Interest",
                  prefixIcon: Icon(Icons.person, color: lightIconsColor,),
                ),
                onChanged: (value) {
                  setState(() {
                    fullName = value;
                  });
                },
                controller: interestInputController,
              ),

              const SizedBox(height: 15.0,),

              TextFormField(
                decoration: textInputDecoration.copyWith(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email_rounded, color: lightIconsColor,),
                ),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                controller: emailInputController,
              ),

              const SizedBox(height: 15.0,),

              IntlPhoneField(
                controller: phoneInputController,
                showCountryFlag: false,
                showDropdownIcon: false,
                initialValue: countryDial,
                onCountryChanged: (country) {
                  setState(() {
                    countryDial = "+${country.dialCode}";
                  });
                },
                decoration: textInputDecoration.copyWith(
                  labelText: "Phone Number",
                  prefixIcon: Icon(Icons.phone_android_rounded, color: lightIconsColor,),
                ),
                // onChanged: (value) {
                //   setState(() {
                //     phoneNumber = value as String;
                //   });
                // },
              ),

              const SizedBox(height: 15.0,),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightScaffoldColor,
                      ),
                      onPressed: () {
                        nameInputController.clear();
                        interestInputController.clear();
                        emailInputController.clear();
                        phoneInputController.clear();
                      },
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightScaffoldColor,
                      ),
                      onPressed: () async {
                        if(fullName.isNotEmpty &&
                        interest.isNotEmpty &&
                        email.isNotEmpty &&
                        phoneNumber.isNotEmpty){
                          var response = await FirebaseFirestore.instance.collection("users")
                              .add({
                            "fullName" : fullName,
                            "interest" : interest,
                            "email" : email,
                            "phoneNumber" : phoneNumber,
                            "timeStamp" : new DateTime.now()
                          });
                          print("response: $response");
                        }
                      },
                      child: Text("Save"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(10.0),
      //   child: Container(
      //     margin: const EdgeInsets.only(top: 10.0),
      //     child: Column(
      //       children: [
      //         Expanded(
      //           child: Container(
      //             //width: 200.0,
      //             child: TextField(
      //               autofocus: true,
      //               autocorrect: true,
      //               decoration: const InputDecoration(
      //                   enabledBorder: OutlineInputBorder(
      //                       borderSide: BorderSide(
      //                           color: Colors.green,
      //                           width: 2.0
      //                       ),
      //                       borderRadius: BorderRadius.all(
      //                           Radius.circular(14.0)
      //                       )
      //                   ),
      //                   hintText: "Name"
      //               ),
      //               controller: nameInputController,
      //             ),
      //           ),
      //         ),
      //         Expanded(
      //           child: Container(
      //             //width: 200.0,
      //             child: TextField(
      //               autofocus: true,
      //               autocorrect: true,
      //               decoration: const InputDecoration(
      //                   enabledBorder: OutlineInputBorder(
      //                       borderSide: BorderSide(
      //                           color: Colors.green,
      //                           width: 2.0
      //                       ),
      //                       borderRadius: BorderRadius.all(
      //                           Radius.circular(14.0)
      //                       )
      //                   ),
      //                   hintText: "Interest"
      //               ),
      //               controller: interestInputController,
      //             ),
      //           ),
      //         ),
      //         Expanded(
      //           child: Container(
      //             //width: 200.0,
      //             child: TextField(
      //               autofocus: true,
      //               autocorrect: true,
      //               decoration: const InputDecoration(
      //                   enabledBorder: OutlineInputBorder(
      //                       borderSide: BorderSide(
      //                           color: Colors.green,
      //                           width: 2.0
      //                       ),
      //                       borderRadius: BorderRadius.all(
      //                           Radius.circular(14.0)
      //                       )
      //                   ),
      //                   hintText: "email"
      //               ),
      //               controller: emailInputController,
      //             ),
      //           ),
      //         ),
      //         Expanded(
      //           child: Container(
      //             //width: 200.0,
      //             child: TextField(
      //               autofocus: true,
      //               autocorrect: true,
      //               decoration: const InputDecoration(
      //                   enabledBorder: OutlineInputBorder(
      //                       borderSide: BorderSide(
      //                           color: Colors.green,
      //                           width: 2.0
      //                       ),
      //                       borderRadius: BorderRadius.all(
      //                           Radius.circular(14.0)
      //                       )
      //                   ),
      //                   hintText: "Phone Number"
      //               ),
      //               controller: phoneInputController,
      //             ),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.all(10.0),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               ElevatedButton(
      //                 onPressed: () {
      //                   nameInputController.clear();
      //                   interestInputController.clear();
      //                   emailInputController.clear();
      //                   phoneInputController.clear();
      //                 },
      //                 child: Text("Cancel"),
      //               ),
      //               ElevatedButton(
      //                 onPressed: () async {
      //                   if(nameInputController.text.isNotEmpty &&
      //                   interestInputController.text.isNotEmpty &&
      //                   emailInputController.text.isNotEmpty &&
      //                   phoneInputController.text.isNotEmpty){
      //                     var response = await FirebaseFirestore.instance.collection("profile")
      //                         .add({
      //                       "name" : nameInputController.text,
      //                       "interest" : interestInputController.text,
      //                       "email" : emailInputController.text,
      //                       "phone" : phoneInputController.text,
      //                       "timeStamp" : new DateTime.now()
      //                     });
      //                     print("response: $response");
      //                   }
      //                 },
      //                 child: Text("Save"),
      //               )
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
