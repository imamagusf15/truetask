import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/task_detail_controller.dart';

class TaskDetailView extends GetView<TaskDetailController> {
  const TaskDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "Task of "),
                  TextSpan(
                    text: 'projectName',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Center(
              child: Text(
                "taskName",
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
                              onPressed: () => controller.updateTaskStatus(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: controller.buttonStatusColor(),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(controller.taskStatus.value),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Priority"),
                        Obx(
                          () => TextButton.icon(
                            onPressed: () => controller.updateTaskPriority(),
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
                          width: 90,
                          height: 36,
                          child: ListView.builder(
                            clipBehavior: Clip.none,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.users.length,
                            itemBuilder: (context, index) {
                              final users = controller.users;
                              if (index <= 2) {
                                return Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  widthFactor: 0.6,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.lightBlue,
                                    maxRadius: 18,
                                    child: Text(users[index].substring(0, 1)),
                                  ),
                                );
                              } else if (index == 3) {
                                return Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  widthFactor: 0.55,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.yellow,
                                    maxRadius: 18,
                                    child: Text('+${users.length - index}'),
                                  ),
                                );
                              } else {
                                return null;
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Dates"), Text("startDate - endDate")],
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
      ),
    );
  }
}
