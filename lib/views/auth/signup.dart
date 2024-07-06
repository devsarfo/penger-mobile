import 'package:flutter/material.dart';
import 'package:penger/resources/app_colours.dart';
import 'package:penger/resources/app_routes.dart';
import 'package:penger/resources/app_spacing.dart';
import 'package:penger/resources/app_strings.dart';
import 'package:penger/resources/app_styles.dart';
import 'package:penger/views/components/form/checkbox_input.dart';
import 'package:penger/views/components/form/text_input.dart';
import 'package:penger/views/components/ui/button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  final nameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColours.bgColour,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColours.bgColour,
          title: Text(AppStrings.signUp, style: AppStyles.appTitle()),
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              TextInputComponent(
                isEnabled: !isLoading,
                isRequired: true,
                textInputType: TextInputType.name,
                focusNode: nameFocus,
                label: AppStrings.name,
                textEditingController: nameEditingController,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(emailFocus),
                textInputAction: TextInputAction.next,
              ),
              AppSpacing.vertical(),
              TextInputComponent(
                isEnabled: !isLoading,
                isRequired: true,
                textInputType: TextInputType.emailAddress,
                focusNode: emailFocus,
                label: AppStrings.emailAddress,
                textEditingController: emailEditingController,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(passwordFocus),
                textInputAction: TextInputAction.next,
              ),
              AppSpacing.vertical(),
              TextInputComponent(
                isEnabled: !isLoading,
                isRequired: true,
                focusNode: passwordFocus,
                label: AppStrings.password,
                textEditingController: passwordEditingController,
                isPassword: true,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).unfocus(),
                textInputAction: TextInputAction.done,
              ),
              AppSpacing.vertical(),
              CheckboxInputComponent(
                isEnabled: !isLoading,
                  label: Text.rich(
                      style: AppStyles.medium(size: 14),
                      TextSpan(text: AppStrings.agreeText, children: [
                        WidgetSpan(child: AppSpacing.horizontal(size: 4)),
                        TextSpan(
                            text: AppStrings.termsAndPrivacy,
                            style: AppStyles.medium(
                                size: 14, color: AppColours.primaryColour))
                      ])),
                  value: false,
                  onChanged: (value) {
                    print(value);
                  }),
              AppSpacing.vertical(),
              ButtonComponent(isLoading: isLoading, label: AppStrings.signUp, onPressed: signup),
              AppSpacing.vertical(size: 16),
              Text(AppStrings.orWith,
                  textAlign: TextAlign.center,
                  style: AppStyles.bold(size: 14, color: AppColours.light20)),
              AppSpacing.vertical(size: 16),
              ButtonComponent(
                  type: ButtonType.light,
                  label: AppStrings.signUpWithGoogle,
                  icon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset("assets/images/google.png"),
                  ),
                  onPressed: () {
                    print("signUpWithGoogle");
                  }),
              AppSpacing.vertical(),
              Text.rich(
                  textAlign: TextAlign.center,
                  style: AppStyles.medium(size: 16),
                  TextSpan(text: AppStrings.alreadyHaveAnAccount, children: [
                    WidgetSpan(child: AppSpacing.horizontal(size: 4)),
                    TextSpan(
                        text: AppStrings.login,
                        style: AppStyles.medium(
                                size: 16, color: AppColours.primaryColour)
                            .copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColours.primaryColour))
                  ]))
            ],
          ),
        ),
      ),
    );
  }

  void signup() {
    FocusScope.of(context).unfocus();
    if(!formKey.currentState!.validate()){
      return;
    }

    setState(() => isLoading = true);

    Future.delayed(const Duration(seconds: 5), () {
      print("success");
      setState(() => isLoading = false);
    });


  }
}
