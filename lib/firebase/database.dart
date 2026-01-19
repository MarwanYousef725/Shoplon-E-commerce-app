import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseUsers {
  final CollectionReference notesCollection = FirebaseFirestore.instance
      .collection('users');

  /// Create a new note (auto-generated ID)
  Future<void> createUser({required String name, required String email}) async {
    await notesCollection.add({
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Get all notes (one-time fetch)
  Future<List<QueryDocumentSnapshot>> getUser() async {
    final snapshot = await notesCollection
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs;
  }

  /// Listen for real-time updates
  Stream<List<QueryDocumentSnapshot>> listenToUser() {
    return notesCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  /// Update a specific note
  Future<void> updateUser({
    required String docId,
    String? name,
    String? email,
  }) async {
    final Map<String, dynamic> updatedData = {};
    if (name != null) updatedData['name'] = name;
    if (email != null) updatedData['email'] = email;

    await notesCollection.doc(docId).update(updatedData);
  }

  /// Delete a note
  Future<void> deleteUser(String docId) async {
    await notesCollection.doc(docId).delete();
  }
}

class DatabaseProducts {
  final CollectionReference notesCollection = FirebaseFirestore.instance
      .collection('Products');

  /// Get all notes (one-time fetch)
  Future<List<Map<String, dynamic>>> getProducts() async {
    var snapshot = await FirebaseFirestore.instance
        .collection("Products")
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  /// Listen for real-time updates
  Stream<List<QueryDocumentSnapshot>> listenToUser() {
    return notesCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }
}

class DatabaseSliders {
  final CollectionReference notesCollection = FirebaseFirestore.instance
      .collection('Sliders');

  /// Get all notes (one-time fetch)
  Future<List<Map<String, dynamic>>> getSliders() async {
    var snapshot = await FirebaseFirestore.instance.collection("Sliders").get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  /// Listen for real-time updates
  Stream<List<QueryDocumentSnapshot>> listenToUser() {
    return notesCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }
}
