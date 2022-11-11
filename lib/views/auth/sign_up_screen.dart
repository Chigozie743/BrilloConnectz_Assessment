import 'package:brillo_connectz_assessment/constants/constant.dart';
import 'package:brillo_connectz_assessment/helper/bottom_navigator.dart';
import 'package:brillo_connectz_assessment/helper/helper_function.dart';
import 'package:brillo_connectz_assessment/services/auth_service.dart';
import 'package:brillo_connectz_assessment/views/home_screen.dart';
import 'package:brillo_connectz_assessment/widgets/text_input.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController phoneController = TextEditingController();
  final List<String> _interestList = ["Basketball", "Bandy", "Football", "Ice Hockey", "MotorSport", "Rugby"];

  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  String interest = "";
  String phoneNumber = "";
  String countryDial = "+1";
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
                  "Brillo Signup",
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Signatra",
                  ),
                ),

                const SizedBox(height: 10.0,),

                Text(
                  "Signup now to connect with buddies",
                  style: TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.w400, fontFamily: "Varela",
                    color: lightTextColor,
                  ),
                ),
                const SizedBox(height: 20.0,),
                Image.asset("images/add-friend.png", scale: 3.5,),

                const SizedBox(height: 20.0,),

              // Text input field for fullName
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
                  validator: (value) {
                    if(value!.isNotEmpty){
                      return null;
                    }else{
                      return "Name can not be empty";
                    }
                  },
                ),

                const SizedBox(height: 15.0,),

                // Text input field for phoneNumber
                IntlPhoneField(
                  //controller: phoneController,
                  showCountryFlag: false,
                  showDropdownIcon: false,
                  initialValue: phoneNumber,
                  onCountryChanged: (country) {
                    setState(() {
                      phoneNumber = "+${country.dialCode}";
                    });
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: "Phone Number",
                    prefixIcon: Icon(Icons.phone_android_rounded, color: lightIconsColor,),
                  ),
                  validator: (value) {
                      if(phoneNumber.isNotEmpty){
                        return null;
                      }else{
                        return "Provide your phone number";
                      }
                    },
                ),

                const SizedBox(height: 15.0,),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: DropdownButtonFormField(
                    isDense: true,
                    icon: const Icon(Icons.arrow_drop_down_circle),
                    iconSize: 22.0,
                    items:  _interestList.map((String interest) {
                      return DropdownMenuItem(
                        value: interest,
                        child: Text(
                          interest,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                    decoration: textInputDecoration.copyWith(
                      labelText: "Interest",
                      prefixIcon: Icon(Icons.email_rounded, color: lightIconsColor,),
                    ),
                    onChanged: (value) {
                      setState(() {
                        interest = value!;
                      });
                    },
                    validator: (value) {
                      if(interest.isNotEmpty){
                        return null;
                      }else{
                        return "Provide your phone number";
                      }
                    },
                  ),
                ),

                const SizedBox(height: 15.0,),

                // Text input field for email
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
                  validator: (value) {
                    return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!)
                        ? null
                        : "Please enter a valid email";
                  },
                ),
                const SizedBox(height: 15.0,),

                // Text input field for password
                TextFormField(
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock, color: lightIconsColor,),
                  ),
                  onChanged: (value) {
                    setState(() {
                      password = value;
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
                      "Sign Up",
                      style:
                      TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () {
                      signup();
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text.rich(TextSpan(
                  text: "Already have an account? ",
                  style: const TextStyle(
                      color: Colors.black, fontSize: 14),
                  children: <TextSpan>[
                    TextSpan(
                        text: "Login now",
                        style: TextStyle(
                            color: lightScaffoldColor,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            nextScreen(context, const LoginScreen());
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

  signup() async{
    if(formKey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });
      await authService
          .signupWithEmailandPassword(fullName, email, password, phoneNumber, interest)
          .then((value) async {
        if (value == true) {
          // saving the shared preference state
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);
          await HelperFunctions.saveUserPhoneSF(phoneNumber);
          await HelperFunctions.saveUserInterestSF(interest);
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
