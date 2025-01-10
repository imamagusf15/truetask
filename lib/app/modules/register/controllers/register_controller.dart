import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPassController = TextEditingController();
  final passVisible = false.obs;
  final confPassVisible = false.obs;

  String? validateConfPassword(value) {
    if (value != passwordController.text) {
      return 'Password tidak sesuai';
    } else {
      return null;
    }
  }
}
