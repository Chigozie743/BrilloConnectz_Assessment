import 'package:brillo_connectz_assessment/constants/constant.dart';
import 'package:brillo_connectz_assessment/helper/bottom_navigator.dart';
import 'package:brillo_connectz_assessment/helper/helper_function.dart';
import 'package:brillo_connectz_assessment/services/auth_service.dart';
import 'package:brillo_connectz_assessment/services/database_service.dart';
import 'package:brillo_connectz_assessment/views/home_screen.dart';
import 'package:brillo_connectz_assessment/widgets/text_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _isLoading = false;

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? Center(
        child: CircularProgressIndicator(
          color: lightScaffoldColor,),)
          : SingleChildScrollView( //To control overflow using SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "BrilloConnectz",
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Signatra",
                  ),
                ),

                const SizedBox(height: 10.0,),

                Text(
                  "Login to connect buddies with same interest",
                  style: TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.w400, fontFamily: "Varela",
                    color: lightTextColor,
                  ),
                ),
                const SizedBox(height: 20.0,),
                Image.asset("images/profile.png", scale: 2.5,),

                const SizedBox(height: 20.0,),

                TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email_rounded, color: lightIconsColor,),
                    ),
                  onChanged: (value) {
                      setState(() {
                        email = value;
                        print(email);
                      });
                  },
                  validator: (value) {
                    return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!)
                        ? null
                        : "Please enter a valid email";
                  },
                ),
                const SizedBox(height: 15.0,),

                TextFormField(
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock, color: lightIconsColor,),
                  ),
                  onChanged: (value) {
                    setState(() {
                      password = value;
                      print(password);
                    });
                  },
                  validator: (value) {
                    if (value!.length < 6) {
                      return "Password must be at least 6 characters";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lightScaffoldColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: const Text(
                      "Sign In",
                      style:
                      TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () {
                      login();
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text.rich(TextSpan(
                  text: "Don't have an account? ",
                  style: const TextStyle(
                      color: Colors.black, fontSize: 14),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Register here",
                      style: TextStyle(
                          color: lightScaffoldColor,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                           nextScreen(context, const SignUpScreen());
                        }
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async{
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .loginWithUserNameandPassword(email, password)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
          await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
              .gettingUserData(email);
          // saving the values to our shared preferences
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(snapshot.docs[0]['fullName']);
          nextScreenReplace(context, const BottomNavigator());
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
