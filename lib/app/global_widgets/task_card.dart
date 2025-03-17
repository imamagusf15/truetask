import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:truetask/app/data/models/task.dart';
import 'package:truetask/app/routes/app_pages.dart';

class TaskCardItem extends StatelessWidget {
  final Task task;
  final String projectName;
  const TaskCardItem({
    super.key,
    required this.task,
    required this.projectName,
  });

  @override
  Widget build(BuildContext context) {
    final formatDate = DateFormat("dd-MM-yyy");

    Color statusColor() {
      Color color;
      switch (task.status) {
        case 'In Progress':
          color = Colors.amber;
          break;
        case 'Completed':
          color = Colors.green;
          break;
        default:
          color = Colors.grey.shade100;
      }
      return color;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      elevation: 3,
      child: ListTile(
        onTap: () => Get.toNamed(Routes.TASK_DETAIL, arguments: task.id),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        title: Text(task.title ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(projectName),
            Row(
              children: [
                Icon(
                  Icons.date_range_outlined,
                  color: Colors.grey,
                ),
                SizedBox(width: 8),
                Text('Deadline: ${formatDate.format(task.dueDate!)}'),
              ],
            ),
          ],
        ),
        leading: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: statusColor(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.assignment_outlined),
        ),
      ),
    );
  }
}
