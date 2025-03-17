import 'package:cloud_firestore/cloud_firestore.dart';

class Invitation {
  String? id;
  String? projectId;
  String? invitedBy;
  String? invitedUser;
  String? status;
  DateTime? date;

  Invitation({
    this.id,
    this.projectId,
    this.invitedBy,
    this.invitedUser,
    this.status,
    this.date,
  });

  factory Invitation.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Invitation(
      id: snapshot.id,
      projectId: data?['projectId'],
      invitedBy: data?['invitedBy'],
      invitedUser: data?['invitedUser'],
      status: data?['status'],
      date: (data?['date'] as Timestamp).toDate(),
    );
  }

  toFirestore() {
    return {
      'projectId': projectId,
      'invitedBy': invitedBy,
      'invitedUser': invitedUser,
      'status': status,
      'date': date,
    };
  }
}
