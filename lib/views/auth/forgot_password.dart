import 'package:flutter/material.dart';
import 'package:penger/controllers/auth.dart';
import 'package:penger/resources/app_colours.dart';
import 'package:penger/resources/app_routes.dart';
import 'package:penger/resources/app_spacing.dart';
import 'package:penger/resources/app_strings.dart';
import 'package:penger/resources/app_styles.dart';
import 'package:penger/utils/helper.dart';
import 'package:penger/views/components/form/text_input.dart';
import 'package:penger/views/components/ui/app_bar.dart';
import 'package:penger/views/components/ui/button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailEditingController = TextEditingController();

  final _emailFocus = FocusNode();

  bool _isLoading = false;

  Map<String, dynamic> _errors = {};

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColours.bgColour,
        appBar: buildAppBar(context, AppStrings.forgotPasswordTitle),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            AppSpacing.vertical(size: 48),
            Text(AppStrings.forgotPasswordHint,
                style: AppStyles.medium(size: 24)),
            AppSpacing.vertical(size: 48),
            Form(
              key: _formKey,
              child: TextInputComponent(
                error: _errors['email']?.join(', '),
                isEnabled: !_isLoading,
                isRequired: true,
                textInputType: TextInputType.emailAddress,
                focusNode: _emailFocus,
                label: AppStrings.emailAddress,
                textEditingController: _emailEditingController,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).unfocus(),
                textInputAction: TextInputAction.next,
              ),
            ),
            AppSpacing.vertical(size: 32),
            ButtonComponent(
                isLoading: _isLoading,
                label: AppStrings.continueText,
                onPressed: _handleContinue),
            AppSpacing.vertical(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _emailFocus.dispose();

    super.dispose();
  }

  Future<void> _handleContinue() async {
    setState(() => _errors = {});

    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);
    final result = await AuthController.resetOtp(_emailEditingController.text.trim());
    setState(() => _isLoading = false);

    if (!result.isSuccess) {
      Helper.snackBar(context, message: result.message, isSuccess: false);
      if (result.errors != null) {
        setState(() => _errors = result.errors!);
      }

      return;
    }

    Navigator.of(context).pushNamed(AppRoutes.forgotPasswordSent, arguments: _emailEditingController.text.trim());
  }
}
