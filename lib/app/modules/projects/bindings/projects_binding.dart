import 'package:get/get.dart';
import 'package:truetask/app/modules/projects/controllers/completed_project_controller.dart';

import 'package:truetask/app/modules/projects/controllers/ongoing_project_controller.dart';

import '../controllers/projects_controller.dart';

class ProjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectsController>(
      () => ProjectsController(),
    );
    Get.put<OngoingProjectController>(
      OngoingProjectController(),
    );
    Get.put<CompletedProjectController>(
      CompletedProjectController(),
    );
  }
}
