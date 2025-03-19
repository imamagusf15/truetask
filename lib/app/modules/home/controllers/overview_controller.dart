import 'package:get/get.dart';
import 'package:truetask/app/data/models/task.dart';
import 'package:truetask/app/modules/home/controllers/home_controller.dart';

class OverviewController extends GetxController {
  final projects = Get.find<HomeController>().projects;
  final tasks = Get.find<HomeController>().tasks;
  final searchedProject = Get.find<HomeController>().listProjectSearched;
  final searchedTask = Get.find<HomeController>().listTaskSearched;
  final searchQuery = Get.find<HomeController>().searchQueries;

  List<Task> getProjectTasks(String projectId) {
    return tasks.where((task) => task.projectId == projectId).toList();
  }

  String getProjectTaskName(String taskProjectId) {
    return projects
        .where((project) => project.id == taskProjectId)
        .map((e) => e.name!)
        .single;
  }
}
