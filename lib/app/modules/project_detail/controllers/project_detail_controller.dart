import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truetask/app/data/models/invitation.dart';
import 'package:truetask/app/data/models/project.dart';
import 'package:truetask/app/data/models/task.dart';
import 'package:truetask/app/data/services/firestore_service.dart';
import 'package:truetask/app/modules/home/controllers/home_controller.dart';

class ProjectDetailController extends GetxController {
  final _firestoreService = FirestoreService();
  final projectId = Get.arguments as String;
  final project = Project().obs;
  final tasks = RxList<Task>();
  final todoTasks = RxList<Task>();
  final inProgressTasks = RxList<Task>();
  final completedTasks = RxList<Task>();
  final isLoading = false.obs;

  final emailController = TextEditingController();

  Future<void> getProject() async {
    isLoading.value = true;
    final stream = _firestoreService.fetchProjectById(projectId);

    project.bindStream(stream);
    getTasksProject();
    isLoading.value = false;
  }

  void getTasksProject() {
    final stream = _firestoreService.getAllTask().map(
          (tasks) => tasks
              .where((task) => project.value.tasks?.contains(task.id) ?? false)
              .toList(),
        );
    tasks.bindStream(stream);

    tasks.listen((taskList) {
      todoTasks.assignAll(
        taskList.where((task) => task.status == 'To Do'),
      );
      inProgressTasks.assignAll(
        taskList.where((task) => task.status == 'In Progress'),
      );
      completedTasks.assignAll(
        taskList.where((task) => task.status == 'Completed'),
      );
    });
  }

  Future<void> deleteProject() {
    Get.back();
    return _firestoreService.deleteProject(projectId);
  }

  Future<void> updateProjectStatus() {
    var projectStatus = project.value.status;
    if (projectStatus == 'Ongoing') {
      projectStatus = "Completed";
    } else {
      projectStatus = "Ongoing";
    }
    var data = {'status': projectStatus};
    return _firestoreService.updateProject(data, projectId);
  }

  Future<void> inviteUser() async {
    try {
      final currentUser = Get.find<HomeController>().userModel.value;

      final invitedUser =
          await _firestoreService.readUserDataByEmail(emailController.text);

      final newInvitation = Invitation(
        invitedBy: currentUser.uid,
        invitedUser: invitedUser.uid,
        projectId: projectId,
        status: "pending",
        date: DateTime.now(),
      );

      _firestoreService.sendInvitation(newInvitation);

      Get.snackbar('Success', 'Invitation has been send');
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getProject();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
  }
}
