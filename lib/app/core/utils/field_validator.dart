import 'package:get/get.dart';

class Validator {
  static String? validateField({required String field}) {
    if (field.isEmpty) {
      return 'Field tidak boleh kosong';
    } else {
      return null;
    }
  }

  static String? validateName({required String name}) {
    final regex = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
    if (regex.hasMatch(name)) {
      return 'Nama hanya berisi alfabet';
    } else {
      return null;
    }
  }

  static String? validateEmail({required String email}) {
    if (email.isEmpty) {
      return 'Email tidak boleh kosong';
    } else if (!email.isEmail) {
      return 'Email tidak valid';
    } else {
      return null;
    }
  }

  static String? validatePassword({required String password}) {
    if (password.isEmpty) {
      return 'Password tidak boleh kosong';
    } else if (password.length < 6 || password.length >= 12) {
      return 'Password harus terdiri dari 6-12 karakter';
    } else {
      return null;
    }
  }

  static String? validateConfPassword({
    required String firstPassword,
    required String confPassword,
  }) {
    if (confPassword != firstPassword) {
      return 'Konfirmasi Password tidak sesuai';
    } else if (confPassword.isEmpty) {
      return 'Password tidak boleh kosong';
    } else if (confPassword.length < 6 || confPassword.length >= 12) {
      return 'Password harus terdiri dari 6-12 karakter';
    } else {
      return null;
    }
  }
}
