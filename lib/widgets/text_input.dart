import 'package:brillo_connectz_assessment/constants/constant.dart';
import 'package:flutter/material.dart';

final textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: lightTextColor,),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(14.0),
    borderSide: BorderSide(
      color: lightFocusedColor,
      width: 2.0,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(14.0),
    borderSide: BorderSide(
      color: lightEnabledColor,
      width: 2.0,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(14.0),
    borderSide: BorderSide(
      color: lightErrorColor,
      width: 2.0,
    ),
  ),
);