import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget content;
  final void Function()? onPressed;
  const CustomButton({
    super.key,
    required this.content,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      height: 55,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.lightBlue,
          textStyle: const TextStyle(fontSize: 21),
        ),
        child: content,
      ),
    );
  }
}
