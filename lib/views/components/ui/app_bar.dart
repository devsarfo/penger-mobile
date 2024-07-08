import 'package:flutter/material.dart';
import 'package:penger/resources/app_colours.dart';
import 'package:penger/resources/app_styles.dart';

AppBar buildAppBar(BuildContext context, String title) {
  return AppBar(
    centerTitle: true,
    backgroundColor: AppColours.bgColour,
    title: Text(title, style: AppStyles.appTitle()),
    leading: Navigator.of(context).canPop() ? IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back),
    ): null,
  );
}
