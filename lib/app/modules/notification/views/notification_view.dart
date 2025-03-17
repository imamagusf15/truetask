import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(height: 4),
                itemCount: controller.invitations.length,
                itemBuilder: (context, index) {
                  final invitation = controller.invitations[index];
                  return ListTile(
                    onTap: () {
                      if (invitation.status != 'read') {
                        controller.updateInvitationStatus(invitation.id!);
                      }
                      Get.defaultDialog(
                        title: "Accept Invitation",
                        content: Text(
                            "You have been invited to project ${controller.projectNames[invitation.projectId]} by ${controller.userNames[invitation.invitedBy]}.\nAccept invitation?"),
                        textConfirm: "Yes",
                        textCancel: "No",
                        onConfirm: () {
                          controller.acceptInvitation(invitation.projectId!);
                          Get.back();
                        },
                      );
                    },
                    title: Text("Project Invitation"),
                    subtitle: Obx(() => Text(
                        "${controller.userNames[invitation.invitedBy]} has invited you to their project\n${timeago.format(invitation.date!)}")),
                    leading: invitation.status != 'read'
                        ? CircleAvatar(backgroundColor: Colors.red, radius: 5)
                        : SizedBox(),
                  );
                },
              ),
      ),
    );
  }
}
