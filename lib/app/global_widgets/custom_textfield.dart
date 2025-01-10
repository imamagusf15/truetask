import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.controller,
    this.validator,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        isDense: true,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.lightBlue,
              ),
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 2,
                color: Colors.lightBlue,
              ),
            ),
        errorBorder: errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
        focusedErrorBorder: focusedErrorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 2,
                color: Colors.red,
              ),
            ),
      ),
    );
  }
}
