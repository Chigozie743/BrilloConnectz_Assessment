import 'package:brillo_connectz_assessment/constants/constant.dart';
import 'package:brillo_connectz_assessment/services/auth_service.dart';
import 'package:brillo_connectz_assessment/views/auth/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            nextScreenReplace(context, const LoginScreen());
          },
          child: Text("LOGOUT"),
        ),
      ),
    );
  }
}
