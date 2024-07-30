import 'package:flutter/material.dart';
import 'package:penger/resources/app_colours.dart';
import 'package:penger/resources/app_routes.dart';
import 'package:penger/resources/app_spacing.dart';
import 'package:penger/resources/app_strings.dart';
import 'package:penger/resources/app_styles.dart';
import 'package:penger/views/components/ui/button.dart';

class ForgotPasswordSentScreen extends StatefulWidget {
  const ForgotPasswordSentScreen({super.key});

  @override
  State<ForgotPasswordSentScreen> createState() =>
      _ForgotPasswordSentScreenState();
}

class _ForgotPasswordSentScreenState extends State<ForgotPasswordSentScreen> {
  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: AppColours.bgColour,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          AppSpacing.vertical(),
          Center(
            child: Image.asset("assets/images/email.png",
                width: MediaQuery.of(context).size.width / 1.5),
          ),
          AppSpacing.vertical(size: 16),
          Text(AppStrings.yourEmailIsOnTheWay,
              style: AppStyles.medium(size: 24), textAlign: TextAlign.center),
          AppSpacing.vertical(),
          Text(AppStrings.yourEmailIsOnTheWayHint.replaceAll(":email", email),
              style: AppStyles.regular1(), textAlign: TextAlign.center),
          AppSpacing.vertical(),
          ButtonComponent(
              label: AppStrings.continueText,
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.resetPassword, arguments: email)),
          AppSpacing.vertical(),
        ],
      ),
    );
  }
}
