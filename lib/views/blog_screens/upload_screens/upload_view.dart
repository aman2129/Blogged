import 'dart:io';
import 'package:blog_app/data_model/data_model.dart';
import 'package:blog_app/views/blog_screens/blog_home/blog_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadView extends StatefulWidget {
  const UploadView({Key? key}) : super(key: key);

  @override
  State<UploadView> createState() => _UploadViewState();
}

class _UploadViewState extends State<UploadView> {
  bool isLoading = false;
  late final BlogDataModel blogDataModel;
  bool isButtonActive = false;
  File? image;
  String id = DateTime.now().millisecondsSinceEpoch.toString();

  final _formKey = GlobalKey<FormState>();
  String imageUrl = '';
  DocumentReference documentReference = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid);
  late CollectionReference collectionReference =
      documentReference.collection('blogs');

  late final TextEditingController _desc;
  late final TextEditingController _title;

  @override
  void initState() {
    _desc = TextEditingController();
    _title = TextEditingController();

    _title.addListener(() {
      final isButtonActive = _title.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
    _desc.addListener(() {
      final isButtonActive = _desc.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    super.dispose();
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? tempImage = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(tempImage!.path);
    });
  }

  Future<void> removeImage() async {
    setState(() {
      image = null;
    });
  }

  Future<void> uploadImageToFirebaseStorage() async {
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceImagesDir = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceImagesDir.child(imageFileName);

    try {
      await referenceImageToUpload.putFile(File(image!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (e) {
      throw Exception('Something bad happened');
    }
  }

  Future<void> elevatedButton() async {
      if (_formKey.currentState!.validate()) {
        await uploadImageToFirebaseStorage();
        final String desc = _desc.text;
        final String title = _title.text;
        await collectionReference.doc(id).set({
          'id': id,
          'imageUrl': imageUrl,
          'title': title,
          'desc': desc,
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'const': 'const'
        });
        await Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const BlogView(),
          ),
          (route) => false,
        );
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Write a blog'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: 200.0,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: IconButton(
                              onPressed: () {
                                getImage();
                              },
                              icon: const Icon(Icons.add_a_photo_outlined),
                            ),
                          ),
                          image == null ? const Text('') : enableUpload(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: _title,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white70,
                        filled: true,
                        labelText: 'Write a title',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.lightBlueAccent,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      maxLines: 2,
                      maxLength: 50,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: _desc,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white70,
                        filled: true,
                        labelText: 'Write description',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.lightBlueAccent,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      maxLines: 10,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          disabledForegroundColor:
                              Colors.blueGrey.withOpacity(0.50),
                          disabledBackgroundColor:
                              Colors.blueGrey.withOpacity(0.40),
                        ),
                        onPressed: isButtonActive
                            ? () async {
                                setState(() {
                                  isLoading = true;
                                });
                                await elevatedButton();
                                await Future.delayed(const Duration(seconds: 2), () {
                                });
                              }
                            : null,
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text('Upload'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      height: 200.0,
      width: double.maxFinite,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.lightBlueAccent),
          borderRadius: BorderRadius.circular(15.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Stack(
          children: [
            Image.file(
              image!,
              fit: BoxFit.cover,
              height: 300,
              width: double.maxFinite,
            ),
            IconButton(
              onPressed: () async {
                removeImage();
              },
              icon: const Icon(Icons.cancel_rounded),
            )
          ],
        ),
      ),
    );
  }
}
