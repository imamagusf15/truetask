import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truetask/app/data/models/project.dart';
import 'package:truetask/app/data/services/firestore_service.dart';
import 'package:truetask/app/modules/home/controllers/home_controller.dart';

class CreateProjectController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  final _db = FirestoreService();
  final selectedDate = ''.obs;

  Future<DateTime?> datePicker(BuildContext context) async {
    // Show date picker and return the value as DateTime when date is selected
    return await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );
  }

  Future<void> addProject() async {
    // Access user data from HomeController
    final user = Get.find<HomeController>().userModel.value;

    if (formKey.currentState!.validate()) {
      // Create new object
      final project = Project(
        name: nameController.text,
        description: descriptionController.text,
        status: 'Ongoing',
        createdBy: user.uid,
        createdAt: DateTime.now(),
        startDate: DateTime.parse(startDateController.text),
        dueDate: DateTime.parse(endDateController.text),
        members: [user.uid!],
      );
      return _db.createProject(project);
    }
  }
}
