import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/adapters.dart';
import '../blog_tile.dart';
import 'package:flutter/material.dart';

class BookmarkView extends StatelessWidget {
  BookmarkView({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser;

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


