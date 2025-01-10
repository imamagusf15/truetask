import 'package:get/get.dart';

import '../controllers/task_create_controller.dart';

class CreateTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateTaskController>(
      () => CreateTaskController(),
    );
  }
}
