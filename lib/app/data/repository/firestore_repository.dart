import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  Future<void> addToFirestore(DocumentReference docRef, dynamic data) {
    try {
      return docRef.set(data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Object?> readFromFirestore(DocumentReference docRef) async {
    try {
      final docSnap = await docRef.get();
      final data = docSnap.data();
      if (data != null) {
        return data;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<Object?> fetchRealtimeFromFirestore(DocumentReference docRef) {
    try {
      return docRef.snapshots().map((event) => event.data());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Object>> readFromFirestoreByField(Query<Object> query) async {
    try {
      final querySnapshot = await query.get();
      final data = querySnapshot.docs.map((doc) => doc.data()).toList();
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<List<Object>> readAllDocs(Query<Object> query) {
    try {
      final querySnap = query.snapshots();
      final listObjData = querySnap.map(
        (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
      );
      return listObjData;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateData(
    DocumentReference docRef,
    Map<String, dynamic> data,
  ) {
    try {
      return docRef.update(data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteData(DocumentReference docRef) {
    try {
      return docRef.delete();
    } catch (e) {
      throw Exception(e);
    }
  }
}
