import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:injectable/injectable.dart';

@injectable
class DataFireStoreRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createCollection(
      {required String collectionName,
      required String docName,
      required Map<String, dynamic> data}) async {
    try {
      final docUser = _firestore.collection(collectionName).doc(docName);
      final result = await docUser.set(data);
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Stream> readCollection({required String collectionName}) async =>
      FirebaseFirestore.instance
          .collection(collectionName)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((e) => e.data()).toList());

  Future<Map<String, dynamic>?> readDocument(
          {required String collectionName,
          required String documentName}) async =>
      FirebaseFirestore.instance
          .collection(collectionName)
          .doc(documentName)
          .get()
          .then((value) {
        return value.data();
      });

  Future<void> updateCollectionField(
      {required String collectionName,
      required String docName,
      required Map<String, dynamic> parameters}) async {
    final docUser = _firestore.collection(collectionName).doc(docName);
    docUser.update(parameters);
  }

  Future<void> deleteCollectionField(
      {required String collectionName,
      required String docName,
      required List<Object> drinkName,
      required String deletedParameter}) async {
    updateCollectionField(
        collectionName: collectionName,
        docName: docName,
        parameters: {deletedParameter: FieldValue.delete()});
  }
}
