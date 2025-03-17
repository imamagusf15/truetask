import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truetask/app/data/models/user_model.dart';
import 'package:truetask/app/data/services/auth_service.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPassController = TextEditingController();
  final _authService = AuthService();
  final isObscure = true.obs;
  final isObscure2 = true.obs;
  final isLoading = false.obs;

  String? validateConfPassword(value) {
    if (value != passwordController.text) {
      return 'Password tidak sesuai';
    } else {
      return null;
    }
  }

  Future<void> signUp() async {
    try {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;

        final userModel = UserModel(
          name: nameController.text,
          email: emailController.text,
        );

        await _authService.registerUser(userModel, passwordController.text);

        Get.snackbar('Authentication', 'Success');
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;

      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> signUpWithGoogle() async {
    try {
      isLoading.value = true;

      await _authService.signInGoogle();

      Get.snackbar("Authentication", "Success");
    } catch (e) {
      isLoading.value = false;

      Get.snackbar("Error", e.toString());
    }
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confPassController.dispose();
  }
}
