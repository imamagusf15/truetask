import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truetask/app/routes/app_pages.dart';

class TaskCardItem extends StatelessWidget {
  const TaskCardItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      elevation: 3,
      child: ListTile(
        onTap: () => Get.toNamed(Routes.TASK_DETAIL),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        title: const Text('taskName'),
        subtitle: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('projectName'),
            Row(
              children: [
                Icon(
                  Icons.date_range_outlined,
                  color: Colors.grey,
                ),
                SizedBox(width: 8),
                Text('Deadline: endDate'),
                // Text('projectName', maxLines: 2)
              ],
            ),
          ],
        ),
        leading: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.assignment_outlined),
        ),
      ),
    );
  }
}
