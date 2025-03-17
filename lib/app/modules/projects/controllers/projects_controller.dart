import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truetask/app/data/models/project.dart';
import 'package:truetask/app/data/models/task.dart';
import 'package:truetask/app/data/services/firestore_service.dart';
import 'package:truetask/app/modules/home/controllers/home_controller.dart';

class ProjectsController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _firestoreService = FirestoreService();
  final userModel = Get.find<HomeController>().userModel.value;

  final projects = RxList<Project>();
  final tasks = RxList<Task>();
  final listProjectSearched = RxList<Project>();

  final searchQueries = ''.obs;

  void getProjects() {
    try {
      final uid = userModel.uid;
      // Fetch all project where project members contains current user ID
      final stream = _firestoreService.getAllProject().map((projects) =>
          projects.where((project) => project.members!.contains(uid)).toList());

      projects.bindStream(stream);
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  void getTasks() {
    try {
      final uid = userModel.uid;

      // Fetch all task where task createdBy current user ID or task assignees contains current user ID
      final stream = _firestoreService.getAllTask().map((tasks) => tasks
          .where((task) =>
              task.createdBy == uid ||
              (task.assignedTo?.contains(uid) ?? false))
          .toList());

      tasks.bindStream(stream);
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  void getDataBySearch(String query) {
    try {
      final uid = userModel.uid ?? '';

      // Fetch all project matches by current user id and given query field name
      final searchedProjectsStream =
          _firestoreService.searchProjectByName(uid, query);

      listProjectSearched.bindStream(searchedProjectsStream);
      searchQueries.value = query;
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  void cancelStream() {
    projects.close();
    tasks.close();
  }

  @override
  void onInit() {
    super.onInit();
    getProjects();
    getTasks();
  }

  @override
  void onClose() {
    super.onClose();
    cancelStream();
  }
}
