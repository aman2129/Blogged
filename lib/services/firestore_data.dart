import 'package:cloud_firestore/cloud_firestore.dart';
import '../data_model/data_model.dart';

class GetData {
  final _db = FirebaseFirestore.instance;

  Future<List<BlogDataModel>> getData() async {
    final snapshot = await _db
        .collectionGroup('blogs')
        .where('const', isEqualTo: 'const')
        .orderBy('id', descending: true)
        .get();
    final userData = snapshot.docs.map((e) {
      return BlogDataModel(
          imageUrl: e['imageUrl'],
          title: e['title'],
          desc: e['desc'],
          userId: e['userId'],
          id: e['id']);
    }).toList();
    return userData;
  }
}
