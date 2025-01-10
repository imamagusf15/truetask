import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:truetask/app/core/utils/field_validator.dart';
import 'package:truetask/app/global_widgets/custom_button.dart';
import 'package:truetask/app/global_widgets/custom_google_button.dart';
import 'package:truetask/app/global_widgets/custom_textfield.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                'assets/image/truetask-logo.png',
                scale: 3,
              ),
              const SizedBox(height: 30),
              Text(
                "Login",
                style: Get.textTheme.headlineSmall,
              ),
              const SizedBox(height: 30),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: controller.emailController,
                      validator: (value) =>
                          Validator.validateEmail(email: value!),
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Email address',
                      prefixIcon:
                          Image.asset('assets/icon/mail.png', width: 15),
                    ),
                    Obx(
                      () => CustomTextField(
                        controller: controller.passwordController,
                        validator: (value) =>
                            Validator.validatePassword(password: value!),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !controller.passVisible.value,
                        hintText: 'Password',
                        prefixIcon: Image.asset('assets/icon/lock.png'),
                        suffixIcon: IconButton(
                          onPressed: () => controller.passVisible.toggle(),
                          icon: controller.passVisible.value
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(Icons.visibility_off_outlined),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                text: 'Sign In',
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {}
                },
              ),
              Row(children: [
                const Expanded(child: Divider()),
                const SizedBox(width: 15),
                Text(
                  'You can connect with',
                  style: TextStyle(color: Get.theme.dividerColor),
                ),
                const SizedBox(width: 15),
                const Expanded(child: Divider()),
              ]),
              CustomGoogleButton(
                onPressed: () {},
                text: 'Sign In With Google',
              ),
              const SizedBox(height: 40),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Don't have account? ",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Create one',
                      style: const TextStyle(color: Colors.lightBlue),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
