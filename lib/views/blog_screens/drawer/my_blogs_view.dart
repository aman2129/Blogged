import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../data_model/data_model.dart';
import '../../../services/firestore_data.dart';
import '../blog_tile.dart';

class MyBlogsView extends StatelessWidget {
  MyBlogsView({
    Key? key,
  }) : super(key: key);
  final Query query = FirebaseFirestore.instance
      .collectionGroup('blogs')
      .where('const', isEqualTo: 'const')
      .orderBy('id', descending: true);
  late final Stream _streamList = query.snapshots();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('My blogs'),
      ),
      body: StreamBuilder(
        stream: _streamList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            List blogList = snapshot.data!.docs
                .map((e) => BlogDataModel(
                    imageUrl: e['imageUrl'],
                    title: e['title'],
                    desc: e['desc'],
                    userId: e['userId'],
                    id: e['id']))
                .toList();
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              itemCount: blogList!.length,
              itemBuilder: (context, index) {
                return blogList[index].userId != user!.uid
                    ? const SizedBox()
                    : BlogTile(
                  blogDataModel: blogList[index],
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
