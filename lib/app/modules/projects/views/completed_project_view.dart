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
              shrinkWrap: true,
              itemCount: controller.completedProjects.isEmpty
                  ? 1
                  : controller.completedProjects.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                if (controller.completedProjects.isNotEmpty) {
                  final project = controller.completedProjects[index];
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
