import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:penger/models/user.dart';
import 'package:penger/resources/app_colours.dart';
import 'package:penger/resources/app_routes.dart';
import 'package:penger/resources/app_strings.dart';
import 'package:penger/views/auth/signup.dart';
import 'package:penger/views/auth/verification.dart';
import 'package:penger/views/home.dart';
import 'package:penger/views/onboarding/splash.dart';
import 'package:penger/views/onboarding/walkthrough.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColours.primaryColour),
        useMaterial3: true,
        fontFamily: 'Inter'
      ),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.walkthrough: (context) => const WalkthroughScreen(),
        AppRoutes.signup: (context) => const SignupScreen(),
        AppRoutes.verification: (context) => const VerificationScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
      },
    );
  }
}