import 'package:brillo_connectz_assessment/helper/bottom_navigator.dart';
import 'package:brillo_connectz_assessment/helper/helper_function.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constants/constant.dart';
import 'views/home_screen.dart';
import 'views/auth/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
//convert to statefulWidget to permit changes with initState
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsersLoggedInStatus();
  }

  getUsersLoggedInStatus() async{
    await HelperFunctions.getUsersLoggedInStatus().then((value) {
      if(value != null){
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Brillo Connectz Assessment',
      theme: ThemeData(
        scaffoldBackgroundColor: lightBackgroundColor,
        primaryColor: lightCardColor,
        backgroundColor: lightBackgroundColor,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: lightIconsColor,
          ),
          backgroundColor: lightScaffoldColor,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: lightTextColor, fontSize: 22.0, fontWeight: FontWeight.bold
          ),
          elevation: 0,
        ),
        iconTheme: IconThemeData(
          color: lightIconsColor
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
          selectionColor: Colors.green,
        ),
      ),
      home: _isSignedIn ? const BottomNavigator() : const LoginScreen(),
    );
  }
}


