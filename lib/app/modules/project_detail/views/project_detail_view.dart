import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:truetask/app/global_widgets/appbar_menu_button.dart';
import 'package:truetask/app/global_widgets/custom_textfield.dart';
import 'package:truetask/app/modules/project_detail/local_widgets/grouped_task.dart';
import 'package:truetask/app/routes/app_pages.dart';

import '../controllers/project_detail_controller.dart';

class ProjectDetailView extends GetView<ProjectDetailController> {
  const ProjectDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Detail'),
        centerTitle: true,
        actions: [
          AppbarMenuButton(
            menuItemList: (context) => [
              PopupMenuItem(
                child: const Text('Add task'),
                onTap: () => Get.toNamed(Routes.CREATE_TASK,
                    arguments: controller.projectId),
              ),
              PopupMenuItem(
                child: const Text('Invite Member'),
                onTap: () => Get.defaultDialog(
                  title: "Invite User",
                  content: CustomTextField(
                    controller: controller.emailController,
                    hintText: "insert user email..",
                  ),
                  onConfirm: () => controller.inviteUser(),
                  textConfirm: 'Invite',
                  textCancel: 'Cancel',
                  contentPadding: EdgeInsets.all(8.0),
                ),
              )
            ],
          )
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        child: const Icon(Icons.assignment_outlined),
                      ),
                      title: Text(controller.project.value.name ?? 'Loading..'),
                      titleTextStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black,
                      ),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () => controller.updateProjectStatus(),
                            child: Text(
                              controller.project.value.status == 'Ongoing'
                                  ? 'Mark as completed'
                                  : 'Mark as ongoing',
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () => controller.deleteProject(),
                            child: Text('Delete Project'),
                          ),
                        ],
                        icon: const Icon(Icons.more_horiz_outlined),
                      ),
                    ),
                    ExpansionTile(
                      title: const Text('To Do'),
                      children: [
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 4),
                          itemCount: controller.todoTasks.length,
                          itemBuilder: (context, index) {
                            final task = controller.todoTasks[index];
                            return GroupedTaskItem(
                              task: task,
                              projectName: controller.project.value.name ?? '',
                            );
                          },
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                    ExpansionTile(
                      title: const Text('In Progress'),
                      children: [
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 4),
                          itemCount: controller.inProgressTasks.length,
                          itemBuilder: (context, index) {
                            final task = controller.inProgressTasks[index];
                            return GroupedTaskItem(
                              task: task,
                              projectName: controller.project.value.name ?? '',
                            );
                          },
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                    ExpansionTile(
                      title: const Text('Completed'),
                      children: [
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 4),
                          itemCount: controller.completedTasks.length,
                          itemBuilder: (context, index) {
                            final task = controller.completedTasks[index];
                            return GroupedTaskItem(
                              task: task,
                              projectName: controller.project.value.name ?? '',
                            );
                          },
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.add),
                      title: const Text('Add group'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
