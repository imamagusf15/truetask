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
              itemCount: controller.ongoingProject.isEmpty
                  ? 1
                  : controller.ongoingProject.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                if (controller.ongoingProject.isNotEmpty) {
                  final project = controller.ongoingProject[index];
                  final projectTasks = controller.getProjectTasks(project.id!);

                  return ProjectCardItem(
                    project: project,
                    users: project.members!,
                    tasks: projectTasks,
                  );
                } else {
                  return SizedBox(
                    width: 320,
                    height: 140,
                    child: Center(child: Text('Empty Project')),
                  );
                }
              },
            )
          : ListView.separated(
              shrinkWrap: true,
              itemCount: controller.searchedProject.isEmpty
                  ? 1
                  : controller.searchedProject.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                if (controller.searchedProject.isNotEmpty) {
                  final project = controller.searchedProject[index];

                  final projectTasks = controller.getProjectTasks(project.id!);
                  return ProjectCardItem(
                    project: project,
                    users: project.members!,
                    tasks: projectTasks,
                  );
                } else {
                  return SizedBox(
                    width: 320,
                    height: 140,
                    child: Center(child: Text('No project found')),
                  );
                }
              },
            ),
    );
  }
}
