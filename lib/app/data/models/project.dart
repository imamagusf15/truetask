import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  String? id;
  String? name;
  String? description;
  String? status;
  String? createdBy;
  DateTime? createdAt;
  DateTime? startDate;
  DateTime? dueDate;
  List<String>? members;
  List<String>? tasks;

  Project({
    this.id = '',
    this.name,
    this.description,
    this.status,
    this.createdBy,
    this.createdAt,
    this.startDate,
    this.dueDate,
    this.members,
    this.tasks,
  });

  factory Project.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Project(
      id: snapshot.id,
      name: data?['name'],
      description: data?['description'],
      status: data?['status'],
      createdBy: data?['createdBy'],
      createdAt: (data?['createdAt'] as Timestamp).toDate(),
      startDate: (data?['startDate'] as Timestamp).toDate(),
      dueDate: (data?['dueDate'] as Timestamp).toDate(),
      members: (data?['members'] as List).cast<String>(),
      tasks: data?['tasks'] is Iterable ? List.from(data?['tasks']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "description": description,
      "status": status,
      "createdBy": createdBy,
      "createdAt": createdAt,
      "startDate": startDate,
      "dueDate": dueDate,
      "members": members,
      "tasks": tasks
    };
  }
}
