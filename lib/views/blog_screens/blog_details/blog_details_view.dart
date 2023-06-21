import 'package:flutter/material.dart';

import '../../../data_model/data_model.dart';

class BlogDetails extends StatelessWidget {
  BlogDataModel blogDataModel;

  BlogDetails({Key? key, required this.blogDataModel}) : super(key: key);

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
      ),
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height - 320,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(blogDataModel.imageUrl),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                blogDataModel.title,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                blogDataModel.desc,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
