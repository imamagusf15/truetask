import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truetask/app/data/models/task.dart';
import 'package:truetask/app/data/services/firestore_service.dart';
import 'package:truetask/app/modules/home/controllers/home_controller.dart';

class CreateTaskController extends GetxController {
  final selectedDate = ''.obs;
  final selectedProjectId = ''.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _firestoreService = FirestoreService();
  final projects = Get.find<HomeController>().projects;

  Future<DateTime?> datePicker(BuildContext context) async {
    // Show date picker and return the value as DateTime when date is selected
    return await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );
  }

  Future<void> addTask() async {
    if (formKey.currentState!.validate()) {
      final user = Get.find<HomeController>().userModel.value;

      final newTask = Task(
        title: nameController.text,
        description: descriptionController.text,
        status: 'To Do',
        priority: 'Low',
        projectId: selectedProjectId.value,
        createdBy: user.uid,
        startDate: DateTime.parse(startDateController.text),
        dueDate: DateTime.parse(endDateController.text),
      );

      // Get the id from created task
      final newTaskId = await _firestoreService.createTask(newTask);

      // // Fetch all the project task id
      final projectTasks = await _firestoreService
          .getProjectDataById(newTask.projectId!)
          .then((value) => value.tasks ?? <String>[]);

      // Add the new task to the previous project task
      projectTasks.add(newTaskId);

      final data = {"tasks": projectTasks};

      _firestoreService.updateProject(data, newTask.projectId!);
      Get.back();
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Store the passed String data via Route args, if null set to 'no-project'
    selectedProjectId.value = Get.arguments ?? 'no-project';
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    nameController.dispose();
    descriptionController.dispose();
    startDateController.dispose();
    endDateController.dispose();
  }
}
