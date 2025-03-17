import 'package:get/get.dart';
import 'package:truetask/app/data/models/task.dart';
import 'package:truetask/app/modules/home/controllers/home_controller.dart';

class CalendarController extends GetxController {
  final tasks = RxList<Task>();

  // Access a variable projects from HomeController and store it
  final projects = Get.find<HomeController>().projects;

  final selectedDate = DateTime.now().obs;

  void getUserTasks() {
    // Access tasks stream and listen for everytime data is changes
    Get.find<HomeController>().tasks.listen(
      (listTask) {
        // Insert all data where task dueDate is before or equal to selectedDate
        tasks.assignAll(
          listTask.where(
            (field) => field.dueDate!
                .isBefore(selectedDate.value.add(Duration(days: 1))),
          ),
        );
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    getUserTasks();

    // Fetch Task everytime selectedDate is updated
    ever(selectedDate, (_) => getUserTasks());
  }
}
