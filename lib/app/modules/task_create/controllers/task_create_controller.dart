import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateTaskController extends GetxController {
  final selectedDate = ''.obs;
  TextEditingController projectController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  Future<DateTime?> datePicker(BuildContext context) async {
    return await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );
  }

  void addTask() {
    final data = {
      "projectName": projectController.text,
      "taskName": nameController.text,
      "description": descriptionController.text,
      "startDate": startDateController.text,
      "endDate": endDateController.text
    };
    print(data);
  }
}
