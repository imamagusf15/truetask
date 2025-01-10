import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:truetask/app/global_widgets/appbar_menu_button.dart';
import 'package:truetask/app/modules/project_detail/local_widgets/grouped_task.dart';

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
            menuItemList: (context) =>
                [const PopupMenuItem(child: Text('test'))],
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                child: const Icon(Icons.assignment_outlined),
              ),
              title: const Text('Design UIsssssssssssssssssssssssssssssssssss'),
              titleTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
                color: Colors.black,
              ),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(child: Text('Delete Project')),
                ],
                icon: const Icon(Icons.more_horiz_outlined),
              ),
            ),
            ExpansionTile(
              title: const Text('Group 1'),
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => GroupedTaskItem(
                    users: const ['1', '2', '3', '4', '5'],
                    startDate: DateTime.now(),
                    endDate: DateTime.now(),
                    title: 'Userflow',
                    onTap: () {},
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 4),
                  itemCount: 5,
                )
              ],
            ),
            ExpansionTile(
              title: const Text('Group 2'),
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => GroupedTaskItem(
                    users: const ['1', '2', '3', '4', '5'],
                    startDate: DateTime.now(),
                    endDate: DateTime.now(),
                    title: 'Userflow',
                    onTap: () {},
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 4),
                  itemCount: 5,
                )
              ],
            ),
            ExpansionTile(
              title: const Text('Group 3'),
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => GroupedTaskItem(
                    users: const ['1', '2', '3', '4', '5'],
                    startDate: DateTime.now(),
                    endDate: DateTime.now(),
                    title: 'Userflow',
                    onTap: () {},
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 4),
                  itemCount: 5,
                )
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
    );
  }
}
