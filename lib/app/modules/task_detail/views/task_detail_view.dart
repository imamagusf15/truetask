import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/task_detail_controller.dart';

class TaskDetailView extends GetView<TaskDetailController> {
  const TaskDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final formatDate = DateFormat("dd-MM-yyyy");
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.task.value.title ?? 'Loading..')),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text("Assign member"),
                onTap: () => Get.defaultDialog(
                  title: "Assignees",
                  contentPadding: EdgeInsets.all(4.0),
                  content: DropdownMenu<String>(
                    onSelected: (value) => controller.assignUser(value!),
                    dropdownMenuEntries: List.generate(
                      controller.members.length,
                      (index) {
                        final member = controller.members[index];
                        return DropdownMenuEntry(
                          value: member.uid!,
                          label: member.name!,
                          leadingIcon: CircleAvatar(
                            backgroundColor: Colors.lightBlue,
                            maxRadius: 18,
                            child: Text(member.uid!.substring(0, 1)),
                          ),
                          trailingIcon: (controller.task.value.assignedTo ?? [])
                                  .contains(member.uid)
                              ? Icon(Icons.check)
                              : SizedBox(),
                        );
                      },
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                child: Text("Delete"),
                onTap: () => controller.deleteTask(),
              ),
            ],
          )
        ],
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            final task = controller.task.value;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "Task of "),
                        TextSpan(
                          text: controller.projectName.value,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      task.description ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 215,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Status"),
                              Obx(
                                () => SizedBox(
                                  width: 150,
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        controller.updateTaskStatus(),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.buttonStatusColor(),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(task.status!),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Priority"),
                              Obx(
                                () => TextButton.icon(
                                  onPressed: () =>
                                      controller.updateTaskPriority(),
                                  label: Text(controller.taskPriority.value),
                                  style: TextButton.styleFrom(
                                    iconColor: controller.flagColor(),
                                  ),
                                  icon: const Icon(Icons.flag),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Assignee"),
                              SizedBox(
                                height: 36,
                                child: ListView.builder(
                                  clipBehavior: Clip.none,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: (task.assignedTo == null ||
                                          task.assignedTo!.isEmpty)
                                      ? 1
                                      : task.assignedTo!.length,
                                  itemBuilder: (context, index) {
                                    if (task.assignedTo == null ||
                                        task.assignedTo!.isEmpty) {
                                      return const Center(
                                          child: Text('No user assigned'));
                                    }

                                    final users = task.assignedTo![index];
                                    if (index <= 2) {
                                      var length = task.assignedTo!.length;
                                      return Align(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        widthFactor:
                                            length - index == 1 ? 1.0 : 0.6,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.lightBlue,
                                          maxRadius: 18,
                                          child: Text(users.substring(0, 1)),
                                        ),
                                      );
                                    } else if (index == 3) {
                                      return Align(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.yellow,
                                          maxRadius: 18,
                                          child: Text(
                                              '+${task.assignedTo!.length - index}'),
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Dates"),
                              Text(
                                  "${formatDate.format(task.startDate!)} - ${formatDate.format(task.dueDate!)}")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 3,
                    color: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: Get.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Attachment"),
                          SizedBox(
                            width: Get.width,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text("Add an attachment.."),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
