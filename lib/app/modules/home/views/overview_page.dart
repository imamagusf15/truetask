import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truetask/app/global_widgets/project_card.dart';
import 'package:truetask/app/global_widgets/task_card.dart';
import 'package:truetask/app/routes/app_pages.dart';

class OverviewPage extends StatelessWidget {
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
            child: ListView.separated(
              shrinkWrap: true,
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) => ProjectCardItem(
                onTap: () => Get.toNamed(Routes.PROJECT_DETAIL),
                title: 'projectName',
                startDate: DateTime.now(),
                endDate: DateTime.now(),
                users: const ['012', '132', '242', '3124', '4241'],
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
          ListView.separated(
            padding: const EdgeInsets.all(8),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) => const TaskCardItem(),
          )
        ],
      ),
    );
  }
}
