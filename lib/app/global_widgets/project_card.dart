import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:truetask/app/data/models/project.dart';
import 'package:truetask/app/data/models/task.dart';
import 'package:truetask/app/routes/app_pages.dart';

class ProjectCardItem extends StatelessWidget {
  final Project project;
  final List<String> users;
  final List<Task> tasks;
  const ProjectCardItem({
    super.key,
    required this.project,
    required this.users,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    final formatDate = DateFormat("dd-MM-yyyy");
    final completedTask =
        tasks.where((task) => task.status == 'Completed').toList();

    return Card(
      color: Colors.white,
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Get.toNamed(Routes.PROJECT_DETAIL, arguments: project.id),
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 140,
          width: 320,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    project.name!,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 36,
                    child: ListView.builder(
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        if (index <= 2) {
                          return Align(
                            alignment: AlignmentDirectional.topEnd,
                            widthFactor: 0.55,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              maxRadius: 18,
                              child: Text(users[index].substring(0, 1)),
                            ),
                          );
                        } else if (index == 3) {
                          return Align(
                            alignment: AlignmentDirectional.centerEnd,
                            widthFactor: 0.55,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
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
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.date_range_outlined,
                    color: Colors.grey,
                  ),
                  Text(formatDate.format(project.startDate!)),
                  Image.asset('assets/icon/arrow.png'),
                  const Icon(
                    Icons.date_range_outlined,
                    color: Colors.lightBlue,
                  ),
                  Text(
                    formatDate.format(project.dueDate!),
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    tasks.isNotEmpty
                        ? '${(completedTask.length / tasks.length * 100).toInt()}%'
                        : '0%',
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: tasks.isNotEmpty
                          ? completedTask.length / tasks.length
                          : 0.0,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: completedTask.length.toString(),
                            style: TextStyle(color: Colors.grey)),
                        TextSpan(
                            text: '/${tasks.length} tasks',
                            style: TextStyle(color: Colors.black))
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
