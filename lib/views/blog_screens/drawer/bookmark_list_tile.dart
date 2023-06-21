// import 'package:blog_app/services/firestore_data.dart';
// import 'package:blog_app/views/blog_screens/animations/route_animation.dart';
// import 'package:blog_app/views/blog_screens/blog_details/blog_details_view.dart';
// import 'package:blog_app/views/blog_screens/blog_home/blog_view.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
//
// import '../../../data_model/data_model.dart';
// import '../delete_dialog.dart';
//
// class BookmarkTile extends StatelessWidget {
//   final BlogDataModel blogDataModel;
//
//   BookmarkTile({Key? key, required this.blogDataModel}) : super(key: key);
//
//   DocumentReference documentReference = FirebaseFirestore.instance
//       .collection("users")
//       .doc(FirebaseAuth.instance.currentUser!.uid);
//
//   late final collectionReference = documentReference.collection("blogs");
//
//   User? user = FirebaseAuth.instance.currentUser;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(
//           RouteAnimation().createDetailsRoute(blogDataModel),
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.all(10.0),
//         child: Stack(
//           children: [
//             Container(
//               height: 250,
//               width: double.maxFinite,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.0),
//                 image: DecorationImage(
//                     image: NetworkImage(
//                       blogDataModel.imageUrl,
//                     ),
//                     fit: BoxFit.cover),
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 height: 200,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15.0),
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.black12.withOpacity(0.0),
//                       Colors.black,
//                     ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 15.0,
//               left: 10.0,
//               right: 10.0,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text(
//                     blogDataModel.title,
//                     maxLines: 2,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20.0,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   Text(
//                     blogDataModel.desc,
//                     maxLines: 2,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 18.0,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 blogDataModel.userId == user!.uid
//                     ? IconButton(
//                         onPressed: () {
//                           showDeleteDialogBox(context, collectionReference1,
//                               blogDataModel.id);
//                         },
//                         icon: const Icon(
//                           Icons.delete_forever_outlined,
//                           color: Colors.blueGrey,
//                         ),
//                       )
//                     : const SizedBox(),
//                 IconButton(
//                   onPressed: () {
//                     if(Hive.box('bookmark').containsKey(blogDataModel.id)){
//                       Hive.box('bookmark').delete(blogDataModel.id);
//                     }
//                   },
//                   icon: const Icon(
//                     Icons.bookmark,
//                     color: Colors.blueGrey,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
