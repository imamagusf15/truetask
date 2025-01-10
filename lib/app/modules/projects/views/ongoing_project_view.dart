import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:truetask/app/global_widgets/project_card.dart';
import 'package:truetask/app/modules/projects/controllers/ongoing_project_controller.dart';
import 'package:truetask/app/routes/app_pages.dart';

class OngoingProjectView extends GetView<OngoingProjectController> {
  const OngoingProjectView({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) => Obx(
        () => ProjectCardItem(
          onTap: () {
            Get.toNamed(Routes.PROJECT_DETAIL);
          },
          title: controller.count.toString(),
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          users: const ['0', '1', '2', '3', '4'],
        ),
      ),
    );
  }
}
