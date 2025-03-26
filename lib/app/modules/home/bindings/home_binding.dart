import 'package:get/get.dart';
import 'package:truetask/app/modules/home/controllers/calendar_controller.dart';
import 'package:truetask/app/modules/home/controllers/overview_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<OverviewController>(
      () => OverviewController(),
    );
    Get.lazyPut<CalendarController>(
      () => CalendarController(),
    );
  }
}
