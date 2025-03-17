import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String? id;
  String? title;
  String? description;
  String? status;
  String? priority;
  String? projectId;
  List<String>? assignedTo;
  String? createdBy;
  DateTime? startDate;
  DateTime? dueDate;

  Task({
    this.id,
    this.title,
    this.description,
    this.status,
    this.priority,
    this.projectId,
    this.createdBy,
    this.startDate,
    this.dueDate,
    this.assignedTo,
  });

  factory Task.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Task(
      id: snapshot.id,
      title: data?['title'],
      description: data?['description'],
      status: data?['status'],
      priority: data?['priority'],
      projectId: data?['projectId'],
      createdBy: data?['createdBy'],
      startDate: (data?['startDate'] as Timestamp).toDate(),
      dueDate: (data?['dueDate'] as Timestamp).toDate(),
      assignedTo: data?['assignedTo'] is Iterable
          ? List.from(data?['assignedTo'])
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "title": title,
      "description": description,
      "status": status,
      "priority": priority,
      "projectId": projectId,
      "createdBy": createdBy,
      "startDate": startDate,
      "dueDate": dueDate,
      "assignedTo": assignedTo,
    };
  }
}
