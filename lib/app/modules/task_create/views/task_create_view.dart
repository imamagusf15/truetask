import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:truetask/app/core/utils/field_validator.dart';
import 'package:truetask/app/global_widgets/custom_button.dart';
import 'package:truetask/app/global_widgets/custom_textfield.dart';

import '../controllers/task_create_controller.dart';

class CreateTaskView extends GetView<CreateTaskController> {
  CreateTaskView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
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
              const Text('Project'),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownMenu<String>(
                  expandedInsets: EdgeInsets.zero,
                  inputDecorationTheme: const InputDecorationTheme(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  initialSelection: controller.selectedProjectId.value,
                  onSelected: (value) =>
                      controller.selectedProjectId.value = value!,
                  dropdownMenuEntries: [
                    DropdownMenuEntry(
                      label: 'No project',
                      value: 'no-project',
                    ),
                    ...List.generate(controller.projects.length, (index) {
                      var project = controller.projects[index];
                      return DropdownMenuEntry(
                        label: project.name!,
                        value: project.id!,
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text('Title'),
              CustomTextField(
                validator: (value) => Validator.validateField(field: value!),
                textFieldColor: Colors.grey[350],
                controller: controller.nameController,
                hintText: 'insert task title..',
                enabledBorder: noBorder,
                focusedBorder: activeBorder,
              ),
              const SizedBox(height: 8),
              const Text('Description'),
              CustomTextField(
                validator: (value) => Validator.validateField(field: value!),
                textFieldColor: Colors.grey[350],
                controller: controller.descriptionController,
                hintText: 'insert task description',
                enabledBorder: noBorder,
                focusedBorder: activeBorder,
              ),
              const SizedBox(height: 8),
              const Text('Start date'),
              CustomTextField(
                validator: (value) => Validator.validateField(field: value!),
                textFieldColor: Colors.grey[350],
                controller: controller.startDateController,
                hintText: 'choose task start date',
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
                  icon: const Icon(
                    Icons.date_range,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text('End date'),
              CustomTextField(
                validator: (value) => Validator.validateField(field: value!),
                textFieldColor: Colors.grey[350],
                controller: controller.endDateController,
                hintText: 'choose task end date',
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
                  icon: const Icon(
                    Icons.date_range,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                content: Text('Add Task'),
                onPressed: () => controller.addTask(),
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
