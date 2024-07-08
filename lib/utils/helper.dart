import 'package:flutter/material.dart';
import 'package:penger/resources/app_colours.dart';
import 'package:penger/resources/app_styles.dart';

class Helper {
   static snackBar(context, {required String message, bool isSuccess = true}) {
     ScaffoldMessenger.of(context).hideCurrentSnackBar();

     return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         backgroundColor: isSuccess ? AppColours.primaryColour : Colors.red.shade900,
         content: Text(message, style: AppStyles.snackBar())));
   }
}