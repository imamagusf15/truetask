import 'package:get/get.dart';
import 'package:truetask/app/data/models/project.dart';
import 'package:truetask/app/data/models/task.dart';
import 'package:truetask/app/modules/projects/controllers/projects_controller.dart';

class CompletedProjectController extends GetxController {
  final users = RxList<String>();
  final completedProjects = RxList<Project>();
  final searchedProject = RxList<Project>();
  final tasks = Get.find<ProjectsController>().tasks;
  final searchQuery = Get.find<ProjectsController>().searchQueries;

  void getCompletedProjects() {
    Get.find<ProjectsController>().projects.listen(
      (projectList) {
        // Assign all project where project status is Completed
        completedProjects.assignAll(
          projectList.where((field) => field.status == 'Completed'),
        );
      },
    );
  }

  void searchList() {
    Get.find<ProjectsController>().listProjectSearched.listen(
      (listProject) {
        // Assign all searched project where project status is Completed
        searchedProject.assignAll(
          listProject.where((element) => element.status == 'Completed'),
        );
      },
    );
  }

  List<Task> getProjectTasks(String projectId) {
    return tasks.where((task) => task.projectId == projectId).toList();
  }

  @override
  void onInit() {
    super.onInit();
    getCompletedProjects();
    searchList();
  }
}
