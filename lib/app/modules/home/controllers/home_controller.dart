import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truetask/app/data/models/project.dart';
import 'package:truetask/app/data/models/task.dart';
import 'package:truetask/app/data/models/user_model.dart';
import 'package:truetask/app/data/services/auth_service.dart';
import 'package:truetask/app/data/services/firestore_service.dart';

class HomeController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _firestoreService = FirestoreService();
  final _authService = AuthService();
  final userModel = UserModel().obs;
  final projects = RxList<Project>();
  final tasks = RxList<Task>();
  final listProjectSearched = RxList<Project>();
  final listTaskSearched = RxList<Task>();
  final searchQueries = ''.obs;

  Future<void> getUserData() async {
    try {
      final uid = _authService.getCurrentUserId() ?? '';
      // Fetch user data from firestore and store it to userModel
      userModel.value = await _firestoreService.readUserDataById(uid);
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  void getProjects() {
    try {
      final uid = userModel.value.uid;
      // Fetch all project where members contains current user id
      final stream = _firestoreService.getAllProject().map(
            (listProject) => listProject
                .where((project) => project.members!.contains(uid))
                .toList(),
          );
      // Bind the stream to variable
      projects.bindStream(stream);
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  void getTasks() {
    try {
      final uid = userModel.value.uid;
      var listProjectId = projects.map((project) => project.id ?? '').toList();
      // Fetch all the task assigned to or created by current user
      final stream = _firestoreService.getAllTask().map(
            (tasks) => tasks
                .where((task) =>
                    task.createdBy == uid ||
                    listProjectId.contains(task.projectId))
                .toList(),
          );
      tasks.bindStream(stream);
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  void getDataBySearch(String query) {
    try {
      final uid = userModel.value.uid ?? '';

      // Fetch all project matches by current user id and given query field name
      final searchedProjectsStream =
          _firestoreService.searchProjectByName(uid, query);

      // Fetch all title matches by current user id and given query field title
      var listProjectId = projects.map((project) => project.id ?? '').toList();
      final searchedTaskStream =
          _firestoreService.searchTaskByTitle(uid, listProjectId, query);

      listProjectSearched.bindStream(searchedProjectsStream);
      listTaskSearched.bindStream(searchedTaskStream);
      searchQueries.value = query;
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  void closeStream() {
    if (!projects.subject.isClosed) projects.close();
    if (!tasks.subject.isClosed) tasks.close();
    if (!listProjectSearched.subject.isClosed) listProjectSearched.close();
    if (!listTaskSearched.subject.isClosed) listTaskSearched.close();
  }

  void logout() {
    closeStream();

    Future.delayed(
      Duration(milliseconds: 300),
      () => _authService.userLogout(),
    );
  }

  @override
  void onInit() {
    super.onInit();
    getUserData();

    // Call function getProjects when userModel has data
    once(userModel, (_) => getProjects());

    // Call function getTasks when projects has data
    once(projects, (_) => getTasks());
  }
}
