import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:truetask/app/global_widgets/project_card.dart';
import 'package:truetask/app/modules/projects/controllers/ongoing_project_controller.dart';

class OngoingProjectView extends GetView<OngoingProjectController> {
  const OngoingProjectView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.searchQuery.value == ''
          ? ListView.separated(
              shrinkWrap: true,
              itemCount: controller.ongoingProject.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final project = controller.ongoingProject[index];
                return Obx(() {
                  final projectTasks = controller.getProjectTasks(project.id!);
                  return ProjectCardItem(
                    project: project,
                    users: project.members!,
                    tasks: projectTasks,
                  );
                });
              },
            )
          : ListView.separated(
              shrinkWrap: true,
              itemCount: controller.searchedProject.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final project = controller.searchedProject[index];
                return Obx(() {
                  final projectTasks = controller.getProjectTasks(project.id!);
                  return ProjectCardItem(
                    project: project,
                    users: project.members!,
                    tasks: projectTasks,
                  );
                });
              },
            ),
    );
  }
}
