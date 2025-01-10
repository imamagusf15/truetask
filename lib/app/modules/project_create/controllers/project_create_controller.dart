import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProjectController extends GetxController {
  final selectedDate = ''.obs;
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

  void addProject() {
    final data = {
      "taskName": nameController.text,
      "description": descriptionController.text,
      "startDate": startDateController.text,
      "endDate": endDateController.text
    };
    print(data);
  }
}
