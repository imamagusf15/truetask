import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskDetailController extends GetxController {
  final count = 0.obs;
  final users = ["123", "3123", "4123", "453", "534"];

  final taskStatus = ''.obs;
  final taskPriority = ''.obs;
  final taskAsignees = <String>[].obs;

  void updateTaskStatus() {
    switch (taskStatus.value) {
      case 'To Do':
        taskStatus.value = 'In Progress';
        break;
      case 'In Progress':
        taskStatus.value = 'Completed';
        break;
      default:
        taskStatus.value = 'To Do';
    }
  }

  void updateTaskPriority() {
    switch (taskPriority.value) {
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
  }

  Color? buttonStatusColor() {
    Color? colors;
    if (taskStatus.value == 'To Do') {
      colors = Colors.grey;
    } else if (taskStatus.value == 'In Progress') {
      colors = Colors.amber;
    } else {
      colors = Colors.green;
    }
    return colors;
  }

  Color? flagColor() {
    Color? colors;
    if (taskPriority.value == 'Low') {
      colors = Colors.grey;
    } else if (taskPriority.value == 'Normal') {
      colors = Colors.blue;
    } else if (taskPriority.value == 'High') {
      colors = Colors.amber;
    } else {
      colors = Colors.red;
    }
    return colors;
  }

  @override
  void onInit() {
    super.onInit();
    taskStatus.value = 'Ongoing';
    taskPriority.value = 'Low';
  }

  void increment() => count.value++;
}
