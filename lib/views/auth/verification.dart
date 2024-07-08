import 'dart:async';

import 'package:flutter/material.dart';
import 'package:penger/resources/app_colours.dart';
import 'package:penger/resources/app_spacing.dart';
import 'package:penger/resources/app_strings.dart';
import 'package:penger/resources/app_styles.dart';
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
            Text(AppStrings.verificationCodeHint, style: AppStyles.medium()),
            AppSpacing.vertical(),
            InkWell(
              onTap: _startTimer,
              child: Text(AppStrings.resendVerificationCodeHint,
                  style: AppStyles.medium(color: AppColours.primaryColour)
                      .copyWith(
                          decorationColor: AppColours.primaryColour,
                          decoration: TextDecoration.underline)),
            ),
            AppSpacing.vertical(size: 48),
            ButtonComponent(label: AppStrings.verify, onPressed: () {}),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
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
    return Row(
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
                cursorColor: Colors.transparent,
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
    );
  }
}
