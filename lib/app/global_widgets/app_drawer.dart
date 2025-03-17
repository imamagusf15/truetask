import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truetask/app/modules/home/controllers/home_controller.dart';
import 'package:truetask/app/routes/app_pages.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
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
                  Obx(() => Text(
                        controller.userModel.value.name ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Obx(() => Text(
                        controller.userModel.value.email ?? '',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
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
            onTap: () => Get.toNamed(Routes.ABOUT),
          ),
          ListTile(
            leading: const Icon(Icons.notifications_none),
            title: const Text(
              "Notifications",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            onTap: () => Get.toNamed(Routes.NOTIFICATION),
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
            onTap: () => controller.logout(),
          ),
          const SizedBox(height: 100)
        ],
      ),
    );
  }
}
