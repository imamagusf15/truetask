import 'package:get/get.dart';
import 'package:truetask/app/data/models/project.dart';
import 'package:truetask/app/data/models/task.dart';
import 'package:truetask/app/modules/home/controllers/home_controller.dart';

class OverviewController extends GetxController {
  final projects = RxList<Project>();
  final tasks = RxList<Task>();
  final searchedProject = RxList<Project>();
  final searchedTask = RxList<Task>();
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

  void getUserProjects() {
    // Access listproject from HomeController
    Get.find<HomeController>().projects.listen(
          //Store the data to this projects variable
          (listProject) => projects.assignAll(listProject),
        );
  }

  void getUserTasks() {
    Get.find<HomeController>().tasks.listen(
          (listTasks) => tasks.assignAll(listTasks),
        );
  }

  @override
  void onInit() {
    super.onInit();
    getUserProjects();
    getUserTasks();
  }
}
