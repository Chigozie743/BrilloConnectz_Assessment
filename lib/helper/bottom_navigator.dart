
import 'package:brillo_connectz_assessment/constants/constant.dart';
import 'package:brillo_connectz_assessment/views/buddies_screen/buddies_screen.dart';
import 'package:brillo_connectz_assessment/views/chat_screen/chat_screen.dart';
import 'package:brillo_connectz_assessment/views/discover_screen/discover_screen.dart';
import 'package:brillo_connectz_assessment/views/profile_screen/profile_screen.dart';
import 'package:brillo_connectz_assessment/views/setting_and_privacy_screen/setting_and_privacy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {

  List screens = [
    const ProfileScreen(),
    const BuddiesScreen(
      buddiesId: "widget.buddiesId",
      buddiesName: "widget.buddiesName",
      adminName: "admin",
    ),
    const ChatScreen(
      buddiesId: "widget.buddiesId",
      buddiesName: "widget.buddiesName",
      userName: "userName",
    ),
    const DiscoverScreen(),
    const SettingAndPrivacyScreen(),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: lightBackgroundColor,
        type: BottomNavigationBarType.shifting,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: lightFocusedColor,
        unselectedItemColor: lightEnabledColor,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(IconlyBold.profile), label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(IconlyBold.chat), label: "Chat"),
          BottomNavigationBarItem(
              icon: Icon(IconlyBold.user3), label: "Buddies"),
          BottomNavigationBarItem(
              icon: Icon(IconlyBold.search), label: "Discover"),
          BottomNavigationBarItem(
              icon: Icon(IconlyBold.setting), label: "Settings")
        ],
      ),
    );
  }
}
