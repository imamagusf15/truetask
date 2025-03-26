import 'package:get/get.dart';
import 'package:truetask/app/data/models/task.dart';
import 'package:truetask/app/modules/home/controllers/home_controller.dart';

class CalendarController extends GetxController {
  final dueTasks = RxList<Task>();

  // Access a variable projects from HomeController and store it
  final projects = Get.find<HomeController>().projects;
  final tasks = Get.find<HomeController>().tasks;

  final selectedDate = DateTime.now().obs;

  void getUserTasks() {
    // Insert all data where task dueDate is before or equal to selectedDate
    final filteredTask = tasks
        .where((task) => task.dueDate!.isBefore(
              selectedDate.value.add(Duration(days: 1)),
            ))
        .toList();

    dueTasks.assignAll(filteredTask);
  }

  String getProjectName(String taskProjectId) {
    return projects
        .where((project) => project.id == taskProjectId)
        .map((e) => e.name ?? 'Unknown')
        .single;
  }

  @override
  void onInit() {
    super.onInit();
    getUserTasks();

    // Fetch Task everytime selectedDate is updated
    ever(selectedDate, (_) => getUserTasks());
  }
}
