import 'package:flutter/material.dart';
import 'package:penger/controllers/auth.dart';
import 'package:penger/resources/app_colours.dart';
import 'package:penger/resources/app_routes.dart';
import 'package:penger/resources/app_spacing.dart';
import 'package:penger/resources/app_strings.dart';
import 'package:penger/utils/helper.dart';
import 'package:penger/views/components/form/text_input.dart';
import 'package:penger/views/components/ui/app_bar.dart';
import 'package:penger/views/components/ui/button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();
  final _passwordConfirmationEditingController = TextEditingController();

  final _otpFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _passwordConfirmationFocus = FocusNode();

  bool _isLoading = false;

  Map<String, dynamic> _errors = {};
  late String email;

  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)!.settings.arguments as String;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColours.bgColour,
        appBar: buildAppBar(context, AppStrings.resetPassword),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            AppSpacing.vertical(size: 48),
            _resetForm(),
            AppSpacing.vertical(),
            ButtonComponent(
                isLoading: _isLoading,
                label: AppStrings.resetPassword,
                onPressed: _handleReset),
            AppSpacing.vertical(size: 24),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpEditingController.dispose();
    _passwordEditingController.dispose();
    _passwordConfirmationEditingController.dispose();

    _otpFocus.dispose();
    _passwordFocus.dispose();
    _passwordConfirmationFocus.dispose();

    super.dispose();
  }

  Widget _resetForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextInputComponent(
            error: _errors['otp']?.join(', '),
            isEnabled: !_isLoading,
            isRequired: true,
            textInputType: TextInputType.number,
            focusNode: _otpFocus,
            label: AppStrings.verificationCode,
            textEditingController: _otpEditingController,
            onFieldSubmitted: (value) =>
                FocusScope.of(context).requestFocus(_passwordFocus),
            textInputAction: TextInputAction.next,
          ),
          AppSpacing.vertical(),
          TextInputComponent(
            error: _errors['password']?.join(', '),
            isEnabled: !_isLoading,
            isPassword: true,
            isRequired: true,
            focusNode: _passwordFocus,
            label: AppStrings.newPassword,
            textEditingController: _passwordEditingController,
            onFieldSubmitted: (value) =>
                FocusScope.of(context).requestFocus(_passwordConfirmationFocus),
            textInputAction: TextInputAction.next,
          ),
          AppSpacing.vertical(),
          TextInputComponent(
            error: _errors['password_confirmation']?.join(', '),
            isEnabled: !_isLoading,
            isPassword: true,
            isRequired: true,
            focusNode: _passwordConfirmationFocus,
            label: AppStrings.retypeNewPassword,
            textEditingController: _passwordConfirmationEditingController,
            onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  Future<void> _handleReset() async {
    setState(() => _errors = {});

    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if(_passwordEditingController.text != _passwordConfirmationEditingController.text){
      Helper.snackBar(context, message: AppStrings.passwordsDoNotMatch, isSuccess: false);
      FocusScope.of(context).requestFocus(_passwordConfirmationFocus);
      return;
    }

    setState(() => _isLoading = true);

    var result = await AuthController.resetPassword(
        email,
        _otpEditingController.text.trim(),
        _passwordEditingController.text,
        _passwordConfirmationEditingController.text);

    setState(() => _isLoading = false);

    if (!result.isSuccess) {
      Helper.snackBar(context, message: result.message, isSuccess: false);
      if (result.errors != null) {
        setState(() => _errors = result.errors!);
      }

      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (Route<dynamic> route) {
      return route.settings.name == AppRoutes.walkthrough;
    });
  }
}
