import 'package:flutter/material.dart';
import 'package:penger/resources/app_colours.dart';
import 'package:penger/resources/app_routes.dart';
import 'package:penger/resources/app_spacing.dart';
import 'package:penger/resources/app_strings.dart';
import 'package:penger/resources/app_styles.dart';
import 'package:penger/views/components/ui/button.dart';

class SetupAccountScreen extends StatefulWidget {
  const SetupAccountScreen({super.key});

  @override
  State<SetupAccountScreen> createState() => _SetupAccountScreenState();
}

class _SetupAccountScreenState extends State<SetupAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.bgColour,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            AppSpacing.vertical(size: 48),
            Text(AppStrings.letsSetupYourAccount, style: AppStyles.medium(size: 36)),
            AppSpacing.vertical(),
            Text(AppStrings.letsSetupYourAccountHint, style: AppStyles.medium(size: 14)),
            const Spacer(),
            ButtonComponent(label: AppStrings.continueText, onPressed: (){
              Navigator.of(context).pushNamed(AppRoutes.addAccount);
            }),
            AppSpacing.vertical(),
          ],
        ),
      ),
    );
  }
}
