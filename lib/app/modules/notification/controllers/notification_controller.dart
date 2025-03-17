import 'package:get/get.dart';
import 'package:truetask/app/data/models/invitation.dart';
import 'package:truetask/app/data/models/project.dart';
import 'package:truetask/app/data/models/user_model.dart';
import 'package:truetask/app/data/services/firestore_service.dart';
import 'package:truetask/app/modules/home/controllers/home_controller.dart';

class NotificationController extends GetxController {
  final _firestoreService = FirestoreService();
  final userModel = Get.find<HomeController>().userModel.value;
  final invitations = RxList<Invitation>();
  final RxMap<String, String> userNames = <String, String>{}.obs;
  final RxMap<String, String> projectNames = <String, String>{}.obs;
  final isLoading = false.obs;

  void getInvitations() {
    try {
      final currentUserId = userModel.uid ?? '';
      // Fetch all invitation by current user id
      final stream = _firestoreService.getAllInvitation(currentUserId);
      // Bind the stream to variable
      invitations.bindStream(stream);

      invitations.listen(
        (listInvitation) {
          final userIds =
              listInvitation.map((e) => e.invitedBy ?? 'Unknown').toSet();
          final projectIds =
              listInvitation.map((e) => e.projectId ?? 'Unknown').toSet();
          fetchUsernames(userIds);
          fetchProjectNames(projectIds);
        },
      );
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  Future<UserModel> getUserData(String uid) async {
    return await _firestoreService.readUserDataById(uid);
  }

  Future<Project> getProjectData(String id) async {
    return await _firestoreService.getProjectDataById(id);
  }

  Future<void> fetchUsernames(Set<String> userIds) async {
    isLoading.value = true;
    for (var uid in userIds) {
      if (!userNames.containsKey(uid)) {
        final user = await getUserData(uid);
        userNames[uid] = user.name ?? 'Unknown'; // Store username
      }
    }
    isLoading.value = false;
  }

  Future<void> fetchProjectNames(Set<String> projectIds) async {
    isLoading.value = true;
    for (var id in projectIds) {
      if (!projectNames.containsKey(id)) {
        final user = await getProjectData(id);
        projectNames[id] = user.name ?? 'Unknown'; // Store username
      }
    }
    isLoading.value = false;
  }

  Future<void> updateInvitationStatus(String invitationId) {
    final newStatus = {'status': "read"};

    return _firestoreService.updateNotification(newStatus, invitationId);
  }

  Future<void> acceptInvitation(String projectId) async {
    final currentUserId = userModel.uid ?? '';

    // Returns list of project members
    final projectMembers = await getProjectMember(projectId);

    if (projectMembers.contains(currentUserId)) {
      Get.snackbar('Failed', 'You already a member in this project');
    } else {
      projectMembers.add(currentUserId);

      final data = {'members': projectMembers};

      return _firestoreService.updateProject(data, projectId);
    }
  }

  Future<List<String>> getProjectMember(String projectId) async {
    // Returns project data by Id
    final project = await getProjectData(projectId);

    // Set projectMember value, if null set empty list
    final projectMember = project.members ?? <String>[];
    return projectMember;
  }

  @override
  void onInit() {
    super.onInit();
    getInvitations();
  }
}
