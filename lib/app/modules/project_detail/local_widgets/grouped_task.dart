import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:truetask/app/data/models/task.dart';
import 'package:truetask/app/routes/app_pages.dart';

class GroupedTaskItem extends StatelessWidget {
  final Task task;
  final String projectName;
  const GroupedTaskItem({
    super.key,
    required this.task,
    required this.projectName,
  });

  @override
  Widget build(BuildContext context) {
    final formatDate = DateFormat("dd-MM-yyyy");
    return Card(
      color: Colors.white,
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Get.toNamed(Routes.TASK_DETAIL, arguments: task.id),
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    task.title!,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    width: 90,
                    height: 36,
                    child: ListView.builder(
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          task.assignedTo == null ? 1 : task.assignedTo!.length,
                      itemBuilder: (context, index) {
                        if (task.assignedTo != null) {
                          final user = task.assignedTo![index];
                          if (index <= 2) {
                            return Align(
                              alignment: AlignmentDirectional.centerStart,
                              widthFactor: 0.55,
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                maxRadius: 18,
                                child: Text(user.substring(0, 1)),
                              ),
                            );
                          } else if (index == 3) {
                            return Align(
                              alignment: AlignmentDirectional.centerStart,
                              widthFactor: 0.55,
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                maxRadius: 18,
                                child:
                                    Text('+${task.assignedTo!.length - index}'),
                              ),
                            );
                          }
                        }
                        return null;
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.date_range_outlined,
                    color: Colors.grey,
                  ),
                  Text(formatDate.format(task.startDate!)),
                  Image.asset('assets/icon/arrow.png'),
                  const Icon(
                    Icons.date_range_outlined,
                    color: Colors.lightBlue,
                  ),
                  Text(
                    formatDate.format(task.dueDate!),
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
