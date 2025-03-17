import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:truetask/app/core/utils/field_validator.dart';
import 'package:truetask/app/global_widgets/custom_button.dart';
import 'package:truetask/app/global_widgets/custom_textfield.dart';

import '../controllers/project_create_controller.dart';

class CreateProjectView extends GetView<CreateProjectController> {
  CreateProjectView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Project'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/image/create-bg.jpg'),
              const Text('Title'),
              CustomTextField(
                validator: (value) => Validator.validateField(field: value!),
                textFieldColor: Colors.grey[350],
                controller: controller.nameController,
                hintText: 'insert project title..',
                enabledBorder: noBorder,
                focusedBorder: activeBorder,
              ),
              const SizedBox(height: 8),
              const Text('Description'),
              CustomTextField(
                validator: (value) => Validator.validateField(field: value!),
                textFieldColor: Colors.grey[350],
                controller: controller.descriptionController,
                hintText: 'insert project description',
                enabledBorder: noBorder,
                focusedBorder: activeBorder,
              ),
              const SizedBox(height: 8),
              const Text('Start date'),
              CustomTextField(
                validator: (value) => Validator.validateField(field: value!),
                textFieldColor: Colors.grey[350],
                controller: controller.startDateController,
                hintText: 'choose project start date',
                enabledBorder: noBorder,
                focusedBorder: activeBorder,
                readOnly: true,
                suffixIcon: IconButton(
                  onPressed: () async {
                    final selectedDate = await controller.datePicker(context);
                    if (selectedDate != null) {
                      controller.selectedDate.value =
                          DateFormat("yyyy-MM-dd").format(selectedDate);
                      controller.startDateController.text =
                          controller.selectedDate.value;
                    }
                  },
                  icon: const Icon(Icons.date_range),
                ),
              ),
              const SizedBox(height: 8),
              const Text('End date'),
              CustomTextField(
                validator: (value) => Validator.validateField(field: value!),
                textFieldColor: Colors.grey[350],
                controller: controller.endDateController,
                hintText: 'choose project end date',
                enabledBorder: noBorder,
                focusedBorder: activeBorder,
                readOnly: true,
                suffixIcon: IconButton(
                  onPressed: () async {
                    final selectedDate = await controller.datePicker(context);
                    if (selectedDate != null) {
                      controller.selectedDate.value =
                          DateFormat("yyyy-MM-dd").format(selectedDate);
                      controller.endDateController.text =
                          controller.selectedDate.value;
                    }
                  },
                  icon: const Icon(Icons.date_range),
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                content: Text('Add Project'),
                onPressed: () => controller.addProject(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final noBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(12),
  );
  final activeBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.lightBlue, width: 1),
    borderRadius: BorderRadius.circular(12),
  );
}
