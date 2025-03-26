import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truetask/app/global_widgets/project_card.dart';
import 'package:truetask/app/global_widgets/task_card.dart';
import 'package:truetask/app/modules/home/controllers/overview_controller.dart';
import 'package:truetask/app/routes/app_pages.dart';

class OverviewPage extends GetView<OverviewController> {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            onTap: () => Get.toNamed(Routes.PROJECTS),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            leading: Image.asset('assets/icon/projects.png'),
            title: const Text('Our Project'),
            titleTextStyle: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          SizedBox(
            width: Get.width,
            height: 140,
            child: Obx(
              () => controller.searchQuery.value == ''
                  ? ListView.separated(
                      shrinkWrap: true,
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.projects.isEmpty
                          ? 1
                          : controller.projects.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        if (controller.projects.isNotEmpty) {
                          final project = controller.projects[index];
                          return Obx(() {
                            final projectTasks =
                                controller.getProjectTasks(project.id!);
                            return ProjectCardItem(
                              project: project,
                              users: project.members!,
                              tasks: projectTasks,
                            );
                          });
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
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.searchedProject.isEmpty
                          ? 1
                          : controller.searchedProject.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        if (controller.searchedProject.isNotEmpty) {
                          final project = controller.searchedProject[index];
                          return Obx(() {
                            final projectTasks =
                                controller.getProjectTasks(project.id!);
                            return ProjectCardItem(
                              project: project,
                              users: project.members!,
                              tasks: projectTasks,
                            );
                          });
                        } else {
                          return SizedBox(
                            width: 320,
                            height: 140,
                            child: Center(child: Text('No project found')),
                          );
                        }
                      },
                    ),
            ),
          ),
          const SizedBox(height: 8),
          ListTile(
            onTap: () {},
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            leading: Image.asset('assets/icon/task.png'),
            title: const Text('Task'),
            titleTextStyle: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          Obx(
            () => controller.searchQuery.value == ''
                ? ListView.separated(
                    padding: const EdgeInsets.all(8),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        controller.tasks.isEmpty ? 1 : controller.tasks.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      if (controller.tasks.isNotEmpty) {
                        final task = controller.tasks[index];
                        if (task.projectId == 'no-project') {
                          return TaskCardItem(
                            task: task,
                            projectName: 'No Project',
                          );
                        } else {
                          final projectName =
                              controller.getProjectTaskName(task.projectId!);
                          return TaskCardItem(
                            task: task,
                            projectName: projectName,
                          );
                        }
                      } else {
                        return Center(child: Text('Empty task'));
                      }
                    },
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(8),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.searchedTask.isEmpty
                        ? 1
                        : controller.searchedTask.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      if (controller.searchedTask.isNotEmpty) {
                        final task = controller.searchedTask[index];
                        if (task.projectId == 'no-project') {
                          return TaskCardItem(
                            task: task,
                            projectName: 'No Project',
                          );
                        } else {
                          final projectName =
                              controller.getProjectTaskName(task.projectId!);
                          return TaskCardItem(
                            task: task,
                            projectName: projectName,
                          );
                        }
                      } else {
                        return Center(child: Text('No task found'));
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
