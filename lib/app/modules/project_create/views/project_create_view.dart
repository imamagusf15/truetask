import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
      body: Column(
        children: [
          Image.asset('assets/image/create-bg.jpg'),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const Text('Title'),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(12)),
                  child: CustomTextField(
                    controller: controller.nameController,
                    hintText: 'insert project title..',
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
                    hintText: 'insert project description',
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
                    hintText: 'choose project start date',
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
                    hintText: 'choose project end date',
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
                  text: 'Add Project',
                  onPressed: () => controller.addProject(),
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
