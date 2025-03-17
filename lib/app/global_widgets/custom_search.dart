import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    this.onChanged,
    this.filterPressed,
  });

  final void Function(String)? onChanged;
  final void Function()? filterPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      height: 48,
      width: MediaQuery.of(context).size.width,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        shadows: const [
          BoxShadow(color: Colors.grey, blurRadius: 3),
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey.shade400),
          contentPadding: EdgeInsets.zero,
          prefixIcon: Image.asset('assets/icon/search.png'),
          suffixIcon: IconButton(
            onPressed: filterPressed,
            icon: Image.asset('assets/icon/filter.png'),
          ),
          isDense: true,
          hintText: 'Search',
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
