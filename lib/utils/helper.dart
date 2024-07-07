import 'package:flutter/material.dart';
import 'package:penger/resources/app_colours.dart';
import 'package:penger/resources/app_styles.dart';

class Helper {
   static snackBar(context, {required String message, bool isSuccess = true}) {
     return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         backgroundColor: isSuccess ? AppColours.primaryColour : Colors.red.shade500,
         content: Text(message, style: AppStyles.snackBar())));
   }
}