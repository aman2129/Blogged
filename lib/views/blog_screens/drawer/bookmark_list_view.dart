import 'package:blog_app/data_model/bookmark_data_model.dart';
import 'package:blog_app/views/blog_screens/drawer/bookmark_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../data_model/data_model.dart';
import '../blocs/blog_bloc/blog_bloc.dart';
import '../blocs/bookmark_bloc/bookmark_bloc.dart';
import '../blog_tile.dart';
import '../delete_dialog.dart';
import 'package:flutter/material.dart';

class BookmarkView extends StatelessWidget {
  BookmarkView({Key? key}) : super(key: key);

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('bookmark').listenable(),
        builder: (context, box, _) {
          List bookmarks = List.from(box.values);
          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            itemCount: bookmarks.length,
            itemBuilder: (context, index) {
              return bookmarks[index].userId != user!.uid ?
              BlogTile(
                blogDataModel: bookmarks[index],
              ) : const SizedBox();
            },
          );
          // return StreamBuilder(
          //   stream: query.snapshots(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasError) {
          //       return Center(
          //         child: Text('${snapshot.error}'),
          //       );
          //     } else if (snapshot.hasData) {
          //       List blogList = snapshot.data!.docs
          //           .map((e) =>
          //           BlogDataModel(
          //               imageUrl: e['imageUrl'],
          //               title: e['title'],
          //               desc: e['desc'],
          //               userId: e['userId'],
          //               id: e['id']))
          //           .toList();
          //
          //     }
          //     return const Center(child: CircularProgressIndicator());
          //   },
          // );
        },
      ),
    );
  }
}


