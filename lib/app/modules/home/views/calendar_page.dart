import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:truetask/app/global_widgets/task_card.dart';
import 'package:truetask/app/modules/home/controllers/calendar_controller.dart';

class CalendarPage extends GetView<CalendarController> {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CalendarDatePicker(
            initialDate: controller.selectedDate.value,
            firstDate: DateTime(2000),
            lastDate: DateTime(2035),
            onDateChanged: (value) {
              controller.selectedDate.value = value;
            },
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.date_range,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8),
              Obx(
                () => Text(
                  DateFormat("dd-MM-yyyy")
                      .format(controller.selectedDate.value),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Obx(
            () => ListView.separated(
              shrinkWrap: true,
              itemCount: controller.dueTasks.length,
              separatorBuilder: (context, index) => SizedBox(height: 4),
              itemBuilder: (context, index) {
                final task = controller.dueTasks[index];
                if (task.projectId == 'no-project') {
                  return TaskCardItem(task: task, projectName: 'No Project');
                } else {
                  final projectName =
                      controller.getProjectName(task.projectId!);

                  return TaskCardItem(task: task, projectName: projectName);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
