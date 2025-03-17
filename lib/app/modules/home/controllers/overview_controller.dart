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
  final isLoading = false.obs;

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

  void searchList() {
    Get.find<HomeController>().listProjectSearched.listen(
          (listProject) => searchedProject.assignAll(listProject),
        );
    Get.find<HomeController>().listTaskSearched.listen(
          (listTask) => searchedTask.assignAll(listTask),
        );
  }

  @override
  void onInit() {
    super.onInit();
    getUserProjects();
    getUserTasks();
    searchList();
  }
}
