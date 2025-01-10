import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
      body: Column(
        children: [
          Image.asset('assets/image/create-bg.jpg'),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const Text('Project'),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownMenu<String>(
                    controller: controller.projectController,
                    expandedInsets: EdgeInsets.zero,
                    inputDecorationTheme: const InputDecorationTheme(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    initialSelection: 'No Project',
                    onSelected: (value) =>
                        controller.projectController.text = value!,
                    dropdownMenuEntries: List.generate(5, (index) {
                      return DropdownMenuEntry(
                        value: index.toString(),
                        label: index.toString(),
                      );
                    }),
                  ),
                ),
                const Text('Title'),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(12)),
                  child: CustomTextField(
                    controller: controller.nameController,
                    hintText: 'insert task title..',
                    enabledBorder: noBorder,
                    focusedBorder: activeBorder,
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Description'),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(12)),
                  child: CustomTextField(
                    controller: controller.descriptionController,
                    hintText: 'insert task description',
                    enabledBorder: noBorder,
                    focusedBorder: activeBorder,
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Start date'),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(12)),
                  child: CustomTextField(
                    controller: controller.startDateController,
                    hintText: 'choose task start date',
                    enabledBorder: noBorder,
                    focusedBorder: activeBorder,
                    readOnly: true,
                    suffixIcon: IconButton(
                      onPressed: () async {
                        final selectedDate =
                            await controller.datePicker(context);
                        if (selectedDate != null) {
                          controller.selectedDate.value =
                              DateFormat("dd-MM-yyyy").format(selectedDate);
                          controller.startDateController.text =
                              controller.selectedDate.value;
                        }
                      },
                      icon: const Icon(
                        Icons.date_range,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('End date'),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(12)),
                  child: CustomTextField(
                    controller: controller.endDateController,
                    hintText: 'choose task end date',
                    enabledBorder: noBorder,
                    focusedBorder: activeBorder,
                    readOnly: true,
                    suffixIcon: IconButton(
                      onPressed: () async {
                        final selectedDate =
                            await controller.datePicker(context);
                        if (selectedDate != null) {
                          controller.selectedDate.value =
                              DateFormat("dd-MM-yyyy").format(selectedDate);
                          controller.endDateController.text =
                              controller.selectedDate.value;
                        }
                      },
                      icon: const Icon(
                        Icons.date_range,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                CustomButton(
                  text: 'Add Task',
                  onPressed: () => controller.addTask(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  final noBorder = const OutlineInputBorder(
    borderSide: BorderSide.none,
  );
  final activeBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.lightBlue, width: 1),
    borderRadius: BorderRadius.circular(12),
  );
}
