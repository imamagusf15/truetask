import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:truetask/app/global_widgets/app_drawer.dart';
import 'package:truetask/app/global_widgets/appbar_menu_button.dart';
import 'package:truetask/app/global_widgets/custom_search.dart';
import 'package:truetask/app/modules/projects/views/completed_project_view.dart';
import 'package:truetask/app/modules/projects/views/ongoing_project_view.dart';
import 'package:truetask/app/routes/app_pages.dart';

import '../controllers/projects_controller.dart';

class ProjectsView extends GetView<ProjectsController> {
  const ProjectsView({super.key});
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
                      'Projects',
                      style: Get.textTheme.titleLarge,
                    ),
                    AppbarMenuButton(
                      menuItemList: (context) => [
                        PopupMenuItem(
                          child: const Text('Add Task'),
                          onTap: () => Get.toNamed(Routes.CREATE_TASK),
                        ),
                      ],
                    ),
                  ],
                ),
                TabBar(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
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
                  tabs: const [
                    Tab(text: 'Projects'),
                    Tab(text: 'Completed'),
                  ],
                ),
                const CustomSearchBar(),
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
              OngoingProjectView(),
              CompletedProjectView(),
            ],
          ),
        ),
      ),
    );
  }
}
