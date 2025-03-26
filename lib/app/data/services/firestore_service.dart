import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truetask/app/data/models/invitation.dart';
import 'package:truetask/app/data/models/project.dart';
import 'package:truetask/app/data/models/task.dart';
import 'package:truetask/app/data/models/user_model.dart';
import 'package:truetask/app/data/repository/firestore_repository.dart';

class FirestoreService {
  final _firestoreRepository = FirestoreRepository();
  final _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel userModel) {
    try {
      final docRef = _db.collection("users").doc(userModel.uid).withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (userModel, options) => userModel.toFirestore(),
          );
      return _firestoreRepository.addToFirestore(docRef, userModel);
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateUserData(UserModel userModel) {
    try {
      final docRef = _db.collection("users").doc(userModel.uid).withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (userModel, options) => userModel.toFirestore(),
          );
      return _firestoreRepository.addToFirestore(docRef, userModel);
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> readUserDataById(String userId) async {
    try {
      final docRef =
          _db.collection("users").doc(userId).withConverter<UserModel>(
                fromFirestore: UserModel.fromFirestore,
                toFirestore: (userModel, options) => userModel.toFirestore(),
              );
      final userModel =
          await _firestoreRepository.readFromFirestore(docRef) as UserModel;
      return userModel;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> readUserDataByEmail(String email) async {
    try {
      final query = _db
          .collection("users")
          .where('email', isEqualTo: email)
          .withConverter<UserModel>(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (userModel, options) => userModel.toFirestore(),
          );
      final listObjMatches =
          await _firestoreRepository.readFromFirestoreByField(query);
      final userModel = listObjMatches.map((e) => e as UserModel).single;
      return userModel;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<void> createProject(Project project) {
    try {
      final docRef = _db.collection("projects").doc().withConverter(
            fromFirestore: Project.fromFirestore,
            toFirestore: (project, options) => project.toFirestore(),
          );
      return _firestoreRepository.addToFirestore(docRef, project);
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Stream<List<Project>> getAllProject() {
    try {
      final colRef =
          _db.collection("projects").orderBy('dueDate').withConverter<Project>(
                fromFirestore: Project.fromFirestore,
                toFirestore: (project, options) => project.toFirestore(),
              );
      final listObj = _firestoreRepository.readAllDocs(colRef);
      final listProject =
          listObj.map((list) => list.map((obj) => obj as Project).toList());
      return listProject;
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<List<Project>> searchProjectByName(String userId, String query) {
    try {
      if (query == '') {
        return Stream.value([]);
      } else {
        final docRef = _db
            .collection('projects')
            .where('name', isGreaterThanOrEqualTo: query)
            .where('name', isLessThan: '$query\uf7ff')
            .where('members', arrayContains: userId)
            .withConverter<Project>(
              fromFirestore: Project.fromFirestore,
              toFirestore: (project, options) => project.toFirestore(),
            );

        final listObj = _firestoreRepository.readAllDocs(docRef);

        final listProject =
            listObj.map((list) => list.map((obj) => obj as Project).toList());

        return listProject;
      }
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<Project> getProjectDataById(String projectId) async {
    try {
      final docRef =
          _db.collection("projects").doc(projectId).withConverter<Project>(
                fromFirestore: Project.fromFirestore,
                toFirestore: (project, options) => project.toFirestore(),
              );
      final project =
          await _firestoreRepository.readFromFirestore(docRef) as Project;
      return project;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Stream<Project> fetchProjectById(String projectId) {
    try {
      final docRef =
          _db.collection("projects").doc(projectId).withConverter<Project>(
                fromFirestore: Project.fromFirestore,
                toFirestore: (project, options) => project.toFirestore(),
              );
      final project = _firestoreRepository.fetchRealtimeFromFirestore(docRef);
      return project.cast<Project>();
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateProject(Map<String, dynamic> data, String projectId) {
    try {
      final docRef = _db.collection("projects").doc(projectId).withConverter(
            fromFirestore: Project.fromFirestore,
            toFirestore: (project, options) => project.toFirestore(),
          );
      return _firestoreRepository.updateData(docRef, data);
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteProject(String projectId) {
    try {
      final docRef = _db.collection("projects").doc(projectId);
      return _firestoreRepository.deleteData(docRef);
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Stream<List<Task>> getAllTask() {
    try {
      final query =
          _db.collection("tasks").orderBy('dueDate').withConverter<Task>(
                fromFirestore: Task.fromFirestore,
                toFirestore: (task, options) => task.toFirestore(),
              );
      final listObj = _firestoreRepository.readAllDocs(query);
      final listTask =
          listObj.map((list) => list.map((obj) => obj as Task).toList());
      return listTask;
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<List<Task>> searchTaskByTitle(
      String uid, List<String> projectId, String query) {
    try {
      if (query == '') {
        return Stream.value([]);
      } else {
        final queryTask = _db
            .collection('tasks')
            .where('title', isGreaterThanOrEqualTo: query)
            .where('title', isLessThan: '$query\uf7ff')
            .withConverter<Task>(
              fromFirestore: Task.fromFirestore,
              toFirestore: (task, options) => task.toFirestore(),
            );

        final listObj = _firestoreRepository.readAllDocs(queryTask);

        final listTask =
            listObj.map((list) => list.map((obj) => obj as Task).toList());

        final filteredTasks = listTask.map((tasks) => tasks
            .where(
              (task) => task.createdBy == uid || projectId.contains(task.id),
            )
            .toList());
        return filteredTasks;
      }
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Stream<Task> getTaskById(String taskId) {
    try {
      final docRef = _db.collection("tasks").doc(taskId).withConverter<Task>(
            fromFirestore: Task.fromFirestore,
            toFirestore: (task, options) => task.toFirestore(),
          );
      final task = _firestoreRepository.fetchRealtimeFromFirestore(docRef);
      return task.cast<Task>();
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<String> createTask(Task task) async {
    try {
      final docRef = _db.collection("tasks").doc().withConverter(
            fromFirestore: Task.fromFirestore,
            toFirestore: (task, options) => task.toFirestore(),
          );

      await _firestoreRepository.addToFirestore(docRef, task);
      return docRef.id;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateTask(Map<String, dynamic> data, String taskId) {
    try {
      final docRef = _db.collection("tasks").doc(taskId).withConverter(
            fromFirestore: Task.fromFirestore,
            toFirestore: (task, options) => task.toFirestore(),
          );
      return _firestoreRepository.updateData(docRef, data);
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteTask(String taskId) {
    try {
      final docRef = _db.collection("tasks").doc(taskId);
      return _firestoreRepository.deleteData(docRef);
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<void> sendInvitation(Invitation invitation) {
    try {
      final docRef = _db.collection('invitations').doc().withConverter(
            fromFirestore: Invitation.fromFirestore,
            toFirestore: (invitation, options) => invitation.toFirestore(),
          );
      return _firestoreRepository.addToFirestore(docRef, invitation);
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Stream<List<Invitation>> getAllInvitation(String userId) {
    try {
      final query = _db
          .collection("invitations")
          .where('invitedUser', isEqualTo: userId)
          .orderBy('date')
          .withConverter<Invitation>(
            fromFirestore: Invitation.fromFirestore,
            toFirestore: (invitation, options) => invitation.toFirestore(),
          );
      final listObj = _firestoreRepository.readAllDocs(query);
      final listTask =
          listObj.map((list) => list.map((obj) => obj as Invitation).toList());
      return listTask;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateNotification(
      Map<String, dynamic> data, String invitationId) {
    try {
      final docRef =
          _db.collection("invitations").doc(invitationId).withConverter(
                fromFirestore: Invitation.fromFirestore,
                toFirestore: (invitation, options) => invitation.toFirestore(),
              );
      return _firestoreRepository.updateData(docRef, data);
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }
}
