import 'package:blog_app/data_model/data_model.dart';
import 'package:blog_app/views/blog_screens/animations/route_animation.dart';
import 'package:blog_app/views/blog_screens/blog_tile.dart';
import 'package:blog_app/views/blog_screens/drawer/drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../blocs/blog_bloc/blog_bloc.dart';
import '../blocs/internet_bloc/internet_bloc.dart';

enum MenuAction { logout }

class BlogView extends StatefulWidget {
  const BlogView({Key? key}) : super(key: key);

  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  final Query query = FirebaseFirestore.instance
      .collectionGroup('blogs')
      .where('const', isEqualTo: 'const')
      .orderBy('id', descending: true);
  late final Stream _streamList;
  final BlogBloc blogBloc = BlogBloc();
  InternetBloc internetBloc = InternetBloc();

  @override
  void initState() {
    _streamList = query.snapshots();
    blogBloc.add(BlogInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerView(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Blogged',style: TextStyle(color: Colors.black),),
      ),
      body: BlocListener<InternetBloc, InternetState>(
        listener: (context, state) {
          if (state is InternetGainedState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Connected'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is InternetLostState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Not connected'),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Check your connection'),
                backgroundColor: Colors.orange,
              ),
            );
          }
        },
        child: StreamBuilder(
          stream: _streamList,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              List blogList = snapshot.data.docs
                  .map((e) =>
                  BlogDataModel(
                      imageUrl: e['imageUrl'],
                      title: e['title'],
                      desc: e['desc'],
                      userId: e['userId'],
                      id: e['id']))
                  .toList();
              return BlocConsumer<BlogBloc, BlogState>(
                bloc: blogBloc,
                listenWhen: (previous, current) => current is BlogActionState,
                buildWhen: (previous, current) => current is! BlogActionState,
                listener: (context, state) {
                  if (state is BlogNavigateToUploadViewActionState) {
                    Navigator.of(context)
                        .push(RouteAnimation().createUploadRoute());
                  }
                },
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case BlogLoadingState:
                      return const Center(child: CircularProgressIndicator());
                    case BlogLoadedSuccessState:
                      return ValueListenableBuilder(
                        valueListenable: Hive.box('bookmark').listenable(),
                        builder: (context, box, _) {
                          return ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            itemCount: blogList.length,
                            itemBuilder: (context, index) {
                              return BlogTile(
                                blogDataModel: blogList[index],
                              );
                            },
                          );
                        }
                      );
                    case BlogErrorState:
                      return const Scaffold(
                        body: Center(
                          child: Text('Error'),
                        ),
                      );
                    default:
                      return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          blogBloc.add(BlogNavigateToUploadViewEvent());
        },
        backgroundColor: Colors.white,
        tooltip: 'Add a blog',
        child: const Icon(Icons.article_outlined),
      ),
    );
  }
}
