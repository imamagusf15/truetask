import 'package:get/get.dart';

import '../controllers/project_create_controller.dart';

class CreateProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateProjectController>(
      () => CreateProjectController(),
    );
  }
}
