import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truetask/app/data/services/auth_service.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final isObscure = true.obs;
  final isLoading = false.obs;

  final _authService = AuthService();

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      await _authService.signInGoogle();

      // Show snackbar if success signing in
      Get.snackbar("Authentication", "Success");
    } catch (e) {
      isLoading.value = false;

      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> signIn() async {
    try {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;

        await _authService.loginUser(
          emailController.text,
          passwordController.text,
        );

        Get.snackbar("Authentication", "Success");
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  void onClose() {
    super.onClose();
    // Dispose resource prevent from memory leaks
    emailController.dispose();
    passwordController.dispose();
  }
}
