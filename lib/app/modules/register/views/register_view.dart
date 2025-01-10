import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:truetask/app/core/utils/field_validator.dart';
import 'package:truetask/app/global_widgets/custom_button.dart';
import 'package:truetask/app/global_widgets/custom_google_button.dart';
import 'package:truetask/app/global_widgets/custom_textfield.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Let's Get Started",
                  style: Get.textTheme.headlineSmall,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'create an account to continue',
                  style: Get.textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: controller.nameController,
                      validator: (value) =>
                          Validator.validateName(name: value!),
                      keyboardType: TextInputType.name,
                      hintText: 'Name',
                      prefixIcon: Image.asset('assets/icon/person.png'),
                    ),
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
                    Obx(
                      () => CustomTextField(
                        controller: controller.confPassController,
                        validator: (value) =>
                            controller.validateConfPassword(value),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !controller.confPassVisible.value,
                        hintText: 'Confirm password',
                        prefixIcon: Image.asset('assets/icon/lock.png'),
                        suffixIcon: IconButton(
                          onPressed: () => controller.confPassVisible.toggle(),
                          icon: controller.confPassVisible.value
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(Icons.visibility_off_outlined),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                text: 'Sign Up',
                onPressed: () =>
                    controller.formKey.currentState!.validate() ? null : null,
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
                text: 'Sign Up With Google',
              ),
              const SizedBox(height: 40),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Already have account? ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Sign in',
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
