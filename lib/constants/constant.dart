import 'package:flutter/material.dart';

Color lightScaffoldColor = const Color(0xFF4CAF50);
Color lightFocusedColor = const Color(0xFFFFD740);
Color lightEnabledColor = const Color(0xFF4CAF50);
Color lightErrorColor = const Color(0xFFF44336);
Color lightCardColor = const Color(0xFFFfFFFf);
Color lightBackgroundColor = const Color(0xFFE0F7FA);
Color lightIconsColor = const Color(0xFF1B5E20);
Color lightTextColor = const Color(0xff324558);

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
}

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
        textColor: Colors.white,
      ),
    ),
  );
}