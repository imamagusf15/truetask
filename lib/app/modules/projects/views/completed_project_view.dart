import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:truetask/app/modules/projects/controllers/completed_project_controller.dart';

import '../../../global_widgets/project_card.dart';

class CompletedProjectView extends GetView<CompletedProjectController> {
  const CompletedProjectView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.searchQuery.value == ''
          ? ListView.separated(
              itemCount: controller.completedProjects.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final project = controller.completedProjects[index];
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
