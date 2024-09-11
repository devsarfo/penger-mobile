import 'package:flutter/material.dart';
import 'package:penger/resources/app_colours.dart';
import 'package:penger/resources/app_styles.dart';

AppBar buildAppBar(BuildContext context, String title, {Color? backgroundColor, Color? foregroundColor}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: backgroundColor ?? AppColours.bgColour,
    title: Text(title, style: AppStyles.appTitle(color: foregroundColor)),
    leading: Navigator.of(context).canPop() ? IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Icon(Icons.arrow_back, color: foregroundColor),
    ): null,
  );
}
