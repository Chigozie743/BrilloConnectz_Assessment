import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  //Keys
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userPhoneKey = "USERPHONEKEY";
  static String userInterestKey = "USERINTERESTKEY";


  // saving the data to Share Preferences (sf)
  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  static Future<bool> saveUserPhoneSF(String userPhone) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userPhoneKey, userPhone);
  }

  static Future<bool> saveUserInterestSF(String userInterest) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userInterestKey, userInterest);
  }


  //getting the data from share preferences
  static Future<bool?> getUsersLoggedInStatus() async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<String?> getUsersEmailFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future<String?> getUsersNameFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }

  static Future<String?> getUsersPhoneFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userPhoneKey);
  }

  static Future<String?> getUsersInterestFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userInterestKey);
  }
}