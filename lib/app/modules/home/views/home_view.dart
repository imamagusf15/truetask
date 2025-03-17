import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:truetask/app/global_widgets/app_drawer.dart';
import 'package:truetask/app/global_widgets/appbar_menu_button.dart';
import 'package:truetask/app/global_widgets/custom_search.dart';
import 'package:truetask/app/modules/home/views/calendar_page.dart';
import 'package:truetask/app/modules/home/views/overview_page.dart';
import 'package:truetask/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: controller.scaffoldKey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () =>
                          controller.scaffoldKey.currentState!.openDrawer(),
                      icon: Image.asset('assets/icon/drawer.png'),
                    ),
                    Text(
                      'Dashboard',
                      style: Get.textTheme.titleLarge,
                    ),
                    AppbarMenuButton(
                      menuItemList: (context) => [
                        PopupMenuItem(
                          child: const Text('Add project'),
                          onTap: () => Get.toNamed(Routes.CREATE_PROJECT),
                        ),
                        PopupMenuItem(
                          child: const Text('Add task'),
                          onTap: () => Get.toNamed(Routes.CREATE_TASK),
                        ),
                      ],
                    ),
                  ],
                ),
                CustomSearchBar(
                  onChanged: (value) => controller.getDataBySearch(value),
                  filterPressed: () {},
                ),
                TabBar(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 72, vertical: 8),
                  splashBorderRadius: BorderRadius.circular(12),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelColor: Colors.white,
                  labelStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  unselectedLabelColor: Colors.grey,
                  tabs: const [Tab(text: 'Overview'), Tab(text: 'Calendar')],
                ),
              ],
            ),
          ),
        ),
        drawer: const AppDrawer(),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: TabBarView(
            clipBehavior: Clip.none,
            children: [
              OverviewPage(),
              CalendarPage(),
            ],
          ),
        ),
      ),
    );
  }
}
