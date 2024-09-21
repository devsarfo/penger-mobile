import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:penger/models/account.dart';
import 'package:penger/models/account_type.dart';
import 'package:penger/models/currency.dart';
import 'package:penger/models/user.dart';
import 'package:penger/resources/app_colours.dart';
import 'package:penger/resources/app_routes.dart';
import 'package:penger/resources/app_strings.dart';
import 'package:penger/views/account/add_account.dart';
import 'package:penger/views/account/setup_account.dart';
import 'package:penger/views/auth/forgot_password.dart';
import 'package:penger/views/auth/forgot_password_sent.dart';
import 'package:penger/views/auth/login.dart';
import 'package:penger/views/auth/reset_password.dart';
import 'package:penger/views/auth/setup_pin.dart';
import 'package:penger/views/auth/signup.dart';
import 'package:penger/views/auth/signup_success.dart';
import 'package:penger/views/auth/verification.dart';
import 'package:penger/views/home.dart';
import 'package:penger/views/onboarding/splash.dart';
import 'package:penger/views/onboarding/walkthrough.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(CurrencyModelAdapter());
  Hive.registerAdapter(AccountTypeModelAdapter());
  Hive.registerAdapter(AccountModelAdapter());
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
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.verification: (context) => const VerificationScreen(),
        AppRoutes.forgotPassword: (context) => const ForgotPasswordScreen(),
        AppRoutes.forgotPasswordSent: (context) => const ForgotPasswordSentScreen(),
        AppRoutes.resetPassword: (context) => const ResetPasswordScreen(),
        AppRoutes.setupPin: (context) => const SetupPinScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.setupAccount: (context) => const SetupAccountScreen(),
        AppRoutes.addAccount: (context) => const AddAccountScreen(),
        AppRoutes.signupSuccess: (context) => const SignupSuccessScreen(),
      },
    );
  }
}