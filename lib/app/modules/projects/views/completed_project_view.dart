import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:truetask/app/modules/projects/controllers/completed_project_controller.dart';

import '../../../global_widgets/project_card.dart';

class CompletedProjectView extends GetView<CompletedProjectController> {
  const CompletedProjectView({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) => ProjectCardItem(
        onTap: () {
          controller.increment();
          print(controller.count);
        },
        title: 'Design UI',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        users: const ['0', '1', '2', '3', '4'],
      ),
    );
  }
}
