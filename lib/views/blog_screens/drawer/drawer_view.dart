import 'package:blog_app/views/blog_screens/animations/route_animation.dart';
import 'package:blog_app/views/blog_screens/drawer/bookmark_list_view.dart';
import 'package:blog_app/views/blog_screens/drawer/my_blogs_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerView extends StatelessWidget {
  DrawerView({Key? key}) : super(key: key);

  String? email = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
              ),
              color: Colors.white70
            ),
            padding: const EdgeInsets.only(
              left: 10,
              top: 50,
            ),
            height: 108,
            child: Row(
              children: [
                const Icon(
                  Icons.account_box_outlined,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  email!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.article_outlined,
              color: Colors.black,
            ),
            title: const Text(
              'My blogs',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).push(RouteAnimation().createMyBlogsRoute());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.bookmark_border_outlined,
              color: Colors.black,
            ),
            title: const Text(
              'Bookmarks',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).push(
                  RouteAnimation().createBookmarkRoute());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              logoutDialogBox(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> logoutDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Logout'),
            content: const Text('Are you sure you want to logout?'),
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
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/LoginScreen/', (route) => false);
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
