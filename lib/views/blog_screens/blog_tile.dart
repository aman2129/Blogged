import 'package:blog_app/views/blog_screens/animations/route_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../data_model/data_model.dart';
import 'delete_dialog.dart';

class BlogTile extends StatefulWidget {
  final BlogDataModel blogDataModel;

  const BlogTile({Key? key, required this.blogDataModel}) : super(key: key);

  @override
  State<BlogTile> createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {

  DocumentReference documentReference = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid);

  late Query collectionReference = documentReference.collection("blogs");

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          RouteAnimation().createDetailsRoute(widget.blogDataModel),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Container(
              height: 250,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                    image: NetworkImage(
                      widget.blogDataModel.imageUrl,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white12.withOpacity(0.0),
                      Colors.white60,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 15.0,
              left: 10.0,
              right: 10.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.blogDataModel.title,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.blogDataModel.desc,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.blogDataModel.userId == user!.uid
                    ? IconButton(
                        onPressed: () {
                          showDeleteDialogBox(context, collectionReference,
                              widget.blogDataModel.id);
                        },
                        icon: const Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.blueGrey,
                        ),
                      )
                    : const SizedBox(),
                widget.blogDataModel.userId != user!.uid
                    ? IconButton(
                        onPressed: () {
                          if (Hive.box('bookmark')
                              .containsKey(widget.blogDataModel.id)) {
                            Hive.box('bookmark')
                                .delete(widget.blogDataModel.id);
                          } else {
                            Hive.box('bookmark').put(
                                widget.blogDataModel.id, widget.blogDataModel);
                          }
                          // collectionReference1
                          //     .doc(widget.blogDataModel.id)
                          //     .set(
                          //   {
                          //     'id': widget.blogDataModel.id,
                          //     'imageUrl': widget.blogDataModel.imageUrl,
                          //     'title': widget.blogDataModel.title,
                          //     'desc': widget.blogDataModel.desc,
                          //     'userId': widget.blogDataModel.userId,
                          //     'const': 'const'
                          //   },
                          // );
                        },
                        icon: Icon(
                          Hive.box('bookmark')
                                  .containsKey(widget.blogDataModel.id)
                              ? Icons.bookmark
                              : Icons.bookmark_border_outlined,
                          color: Colors.blueGrey,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
