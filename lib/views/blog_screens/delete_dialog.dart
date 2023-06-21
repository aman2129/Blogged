import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'blocs/blog_bloc/blog_bloc.dart';

BlogBloc blogBloc = BlogBloc();

Future<void> showDeleteDialogBox(
  BuildContext context,
  final collectionReference,
  String id,
) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete'),
        content: const Text(
            'Are you sure you want to delete the blog? This action can\'t be undone.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(true);
              await collectionReference.doc(id).delete();
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}
