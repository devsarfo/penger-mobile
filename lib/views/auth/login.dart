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

import '../components/ui/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _isLoading = false;

  Map<String, dynamic> _errors = {};

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColours.bgColour,
        appBar: buildAppBar(context, AppStrings.login),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              AppSpacing.vertical(size: 48),
              _loginForm(),
              AppSpacing.vertical(),
              ButtonComponent(
                  isLoading: _isLoading,
                  label: AppStrings.login,
                  onPressed: _handleLogin),
              AppSpacing.vertical(size: 24),
              InkWell(
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.forgotPassword),
                child: Text(AppStrings.forgotPassword,
                    textAlign: TextAlign.center,
                    style: AppStyles.title3(color: AppColours.primaryColour)),
              ),
              AppSpacing.vertical(),
              Text.rich(
                  textAlign: TextAlign.center,
                  style: AppStyles.medium(size: 16),
                  TextSpan(
                      text: AppStrings.dontHaveAnAccountYet,
                      style: AppStyles.medium(color: AppColours.light20),
                      children: [
                        WidgetSpan(child: AppSpacing.horizontal(size: 4)),
                        WidgetSpan(
                            child: InkWell(
                          onTap: () => Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.signup),
                          child: Text(
                            AppStrings.signUp,
                            style: AppStyles.medium(
                                    size: 16, color: AppColours.primaryColour)
                                .copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColours.primaryColour),
                          ),
                        ))
                      ]))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();

    _emailFocus.dispose();
    _passwordFocus.dispose();

    super.dispose();
  }

  Widget _loginForm() {
    return Column(
      children: [
        TextInputComponent(
          error: _errors['email']?.join(', '),
          isEnabled: !_isLoading,
          isRequired: true,
          textInputType: TextInputType.emailAddress,
          focusNode: _emailFocus,
          label: AppStrings.emailAddress,
          textEditingController: _emailEditingController,
          onFieldSubmitted: (value) =>
              FocusScope.of(context).requestFocus(_passwordFocus),
          textInputAction: TextInputAction.next,
        ),
        AppSpacing.vertical(),
        TextInputComponent(
          error: _errors['password']?.join(', '),
          isEnabled: !_isLoading,
          isRequired: true,
          focusNode: _passwordFocus,
          label: AppStrings.password,
          textEditingController: _passwordEditingController,
          isPassword: true,
          onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
          textInputAction: TextInputAction.done,
        ),
        AppSpacing.vertical(),
      ],
    );
  }

  Future<void> _handleLogin() async {
    setState(() => _errors = {});

    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    var result = await AuthController.login(
        _emailEditingController.text.trim(), _passwordEditingController.text);

    setState(() => _isLoading = false);

    if (!result.isSuccess) {
      Helper.snackBar(context, message: result.message, isSuccess: false);
      if (result.errors != null) {
        setState(() => _errors = result.errors!);
      }

      return;
    }

    final route = await Helper.initialRoute();
    Navigator.of(context).pushNamedAndRemoveUntil(route, (Route<dynamic>route) => false);
  }
}
