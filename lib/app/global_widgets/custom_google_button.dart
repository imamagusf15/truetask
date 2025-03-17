import 'package:flutter/material.dart';

class CustomGoogleButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const CustomGoogleButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      height: 55,
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          textStyle: const TextStyle(fontSize: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox.square(
              dimension: 20,
              child: Image.asset('assets/icon/Google__G__Logo 1.png'),
            ),
            const SizedBox(width: 16),
            Text(text),
          ],
        ),
      ),
    );
  }
}
