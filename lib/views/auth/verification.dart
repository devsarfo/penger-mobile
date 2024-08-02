import 'dart:async';

import 'package:flutter/material.dart';
import 'package:penger/controllers/auth.dart';
import 'package:penger/models/user.dart';
import 'package:penger/resources/app_colours.dart';
import 'package:penger/resources/app_routes.dart';
import 'package:penger/resources/app_spacing.dart';
import 'package:penger/resources/app_strings.dart';
import 'package:penger/resources/app_styles.dart';
import 'package:penger/services/auth.dart';
import 'package:penger/utils/helper.dart';
import 'package:penger/views/components/ui/app_bar.dart';
import 'package:penger/views/components/ui/button.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  var _duration = const Duration(minutes: 5);

  static const otpLength = 6;

  final _formKey = GlobalKey<FormState>();
  final _controllers = List.generate(otpLength, (_) => TextEditingController());
  final _focusNodes = List.generate(otpLength, (_) => FocusNode());

  bool _isLoading = false;

  UserModel? user;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColours.bgColour,
        appBar: buildAppBar(context, AppStrings.verification),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            AppSpacing.vertical(size: 48),
            Text(AppStrings.enterYourVerificationCode,
                style: AppStyles.medium(size: 36)),
            AppSpacing.vertical(size: 32),
            _inputFields(),
            AppSpacing.vertical(size: 48),
            Text(_showDuration(),
                style: AppStyles.title3(color: AppColours.primaryColour)),
            AppSpacing.vertical(),
            Text.rich(
                TextSpan(text: AppStrings.verificationCodeHint1, children: [
                  if (user != null) ...[
                    WidgetSpan(child: AppSpacing.horizontal(size: 4)),
                    TextSpan(
                        text: "${user?.email}.",
                        style:
                            AppStyles.medium(color: AppColours.primaryColour)),
                  ],
                  WidgetSpan(child: AppSpacing.horizontal(size: 4)),
                  TextSpan(text: AppStrings.verificationCodeHint2)
                ]),
                style: AppStyles.medium()),
            AppSpacing.vertical(),
            InkWell(
              onTap: _resend,
              child: Text(AppStrings.resendVerificationCodeHint,
                  style: AppStyles.medium(color: AppColours.primaryColour)
                      .copyWith(
                          decorationColor: AppColours.primaryColour,
                          decoration: TextDecoration.underline)),
            ),
            AppSpacing.vertical(size: 48),
            ButtonComponent(
                isLoading: _isLoading,
                label: AppStrings.verify,
                onPressed: _verify),
            AppSpacing.vertical(size: 48),
            InkWell(
              onTap: _logout,
              child: Text(
                  AppStrings.notUserLogout
                      .replaceAll(":user", user?.name ?? ''),
                  textAlign: TextAlign.center,
                  style: AppStyles.medium(color: AppColours.primaryColour)
                      .copyWith(
                          decorationColor: AppColours.primaryColour,
                          decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _initScreen();
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _initScreen() async {
    user = await AuthService.get();

    _focusNodes[0].requestFocus();
  }

  void _logout() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);
    final result = await AuthController.logout();
    setState(() => _isLoading = false);

    if (!result.isSuccess) {
      Helper.snackBar(context, message: result.message, isSuccess: false);
      return;
    }

    Navigator.of(context).pushReplacementNamed(AppRoutes.walkthrough);
  }

  Future<void> _resend() async {
    if ((_timer != null && _timer!.isActive) || _isLoading) return;

    setState(() => _isLoading = true);
    final result = await AuthController.otp();
    setState(() => _isLoading = false);

    Helper.snackBar(context,
        message: result.message, isSuccess: result.isSuccess);

    if (result.isSuccess) _startTimer();
  }

  Future<void> _verify() async {
    if(!_formKey.currentState!.validate() || _isLoading) return;

    setState(() => _isLoading = true);

    final otp = _controllers.map((controller) => controller.text.trim()).join();
    final result = await AuthController.verify(otp);

    setState(() => _isLoading = false);

    if (!result.isSuccess) {
      Helper.snackBar(context,
          message: result.message, isSuccess: result.isSuccess);
      return;
    }

    final route = await Helper.initialRoute();
    Navigator.of(context).pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration.inSeconds == 0) {
        _duration = const Duration(minutes: 5);
        timer.cancel();
      }

      setState(() {
        _duration -= const Duration(seconds: 1);
      });
    });
  }

  String _showDuration() {
    String minutes = (_duration.inMinutes).toString().padLeft(2, '0');
    String seconds = (_duration.inSeconds % 60).toString().padLeft(2, '0');

    return "$minutes:$seconds";
  }

  Widget _inputFields() {
    return Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(otpLength, (index) {
            return SizedBox(
              width: 48,
              height: 48,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (_controllers[index].text.trim().isEmpty)
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColours.inputBg),
                    ),
                  TextFormField(
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return "*";
                      }

                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    style: AppStyles.bold(size: 32),
                    maxLength: 1,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        counterText: ""),
                    onChanged: (value) {
                      if (value.trim().isNotEmpty &&
                          index < _focusNodes.length - 1) {
                        _focusNodes[index + 1].requestFocus();
                      }
                      if (value.trim().isEmpty && index > 0) {
                        _focusNodes[index - 1].requestFocus();
                      }
                      if (value.trim().isNotEmpty &&
                          index == _focusNodes.length - 1) {
                        FocusScope.of(context).unfocus();
                      }
                      setState(() {});
                    },
                  )
                ],
              ),
            );
          }),
        ));
  }
}
