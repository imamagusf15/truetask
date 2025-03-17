import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truetask/app/data/models/project.dart';
import 'package:truetask/app/data/models/task.dart';
import 'package:truetask/app/data/models/user_model.dart';
import 'package:truetask/app/data/services/firestore_service.dart';

class TaskDetailController extends GetxController {
  final _firestoreService = FirestoreService();

  final task = Task().obs;
  final members = <UserModel>[].obs;
  final taskAsignees = <String>[].obs;
  final projectName = ''.obs;
  final taskId = ''.obs;
  final taskStatus = ''.obs;
  final taskPriority = ''.obs;
  final isLoading = false.obs;

  void getTaskData() {
    isLoading.value = true;

    taskPriority.value = 'Low';
    // Fetch task realtime data
    final stream = _firestoreService.getTaskById(taskId.value);
    task.bindStream(stream);
  }

  Future<Project> fetchProject() async {
    if (task.value.projectId == 'no-project') {}
    return await _firestoreService.getProjectDataById(task.value.projectId!);
  }

  Future<void> getProjectMembers() async {
    isLoading.value = true;

    // Fetch Project data from task project id
    final project = await fetchProject();

    projectName.value = project.name ?? '';

    if (project.members != null) {
      for (var uid in project.members!) {
        // Fetch User data from Firestore by user ID
        final userModel = await _firestoreService.readUserDataById(uid);
        members.add(userModel);
      }
    }
    isLoading.value = false;
  }

  Future<void> assignUser(String uid) async {
    final assignees = task.value.assignedTo ?? <String>[];

    if (assignees.contains(uid)) {
      assignees.remove(uid);
      final data = {'assignedTo': assignees};
      return _firestoreService.updateTask(data, task.value.id!);
    } else {
      assignees.add(uid);
      final data = {'assignedTo': assignees};
      return _firestoreService.updateTask(data, task.value.id!);
    }
  }

  Future<void> updateTaskStatus() {
    switch (task.value.status) {
      case 'To Do':
        taskStatus.value = 'In Progress';
        break;
      case 'In Progress':
        taskStatus.value = 'Completed';
        break;
      default:
        taskStatus.value = 'To Do';
    }
    return _firestoreService.updateTask(
      {"status": taskStatus.value},
      task.value.id!,
    );
  }

  Future<void> updateTaskPriority() {
    switch (task.value.priority) {
      case 'Low':
        taskPriority.value = 'Normal';
        break;
      case 'Normal':
        taskPriority.value = 'High';
        break;
      case 'High':
        taskPriority.value = 'Urgent';
        break;
      default:
        taskPriority.value = 'Low';
    }
    return _firestoreService.updateTask(
      {"priority": taskPriority.value},
      task.value.id!,
    );
  }

  Color? buttonStatusColor() {
    Color? colors;
    if (task.value.status == 'To Do') {
      colors = Colors.grey;
    } else if (task.value.status == 'In Progress') {
      colors = Colors.amber;
    } else {
      colors = Colors.green;
    }
    return colors;
  }

  Color? flagColor() {
    Color? colors;
    if (task.value.priority == 'Low') {
      colors = Colors.grey;
    } else if (task.value.priority == 'Normal') {
      colors = Colors.blue;
    } else if (task.value.priority == 'High') {
      colors = Colors.amber;
    } else {
      colors = Colors.red;
    }
    return colors;
  }

  @override
  void onInit() {
    super.onInit();
    // Store the passed data via Route args
    taskId.value = Get.arguments as String;

    getTaskData();

    once(task, (_) => getProjectMembers());
  }
}
