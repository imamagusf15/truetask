import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truetask/app/routes/app_pages.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            width: Get.width,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 32,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.person,
                        size: 32,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "profileName",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "email@gmail.com",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text(
              "Homepage",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            onTap: () => Get.offAllNamed(Routes.HOME),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text(
              "About",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            onTap: () => Get.offAllNamed(Routes.HOME),
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              "Logout",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            onTap: () => Get.offAllNamed(Routes.HOME),
          ),
          const SizedBox(height: 100)
        ],
      ),
    );
  }
}
