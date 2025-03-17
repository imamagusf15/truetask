import 'package:flutter/material.dart';

class AppbarMenuButton extends StatelessWidget {
  final List<PopupMenuItem<dynamic>> Function(BuildContext) menuItemList;
  const AppbarMenuButton({super.key, required this.menuItemList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: PopupMenuButton(
        style: IconButton.styleFrom(
          backgroundColor: Colors.lightBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        color: Colors.white,
        itemBuilder: menuItemList,
        icon: const Icon(Icons.add),
        iconColor: Colors.white,
      ),
    );
  }
}
