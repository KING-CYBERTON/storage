import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'StorageController.dart';

class PostDataScreen extends StatefulWidget {
  const PostDataScreen({super.key});

  @override
  _PostDataScreenState createState() => _PostDataScreenState();
}

class _PostDataScreenState extends State<PostDataScreen> {
  File? _imageFile;
  XFile? file;

  // Function to pick an image using the image_picker package
  Future<void> _pickImage() async {
    final picker = ImagePicker();

    file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        _imageFile = File(file!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _pickImage();
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: _imageFile != null
                        ? kIsWeb
                            ? Image.network(_imageFile!.path)
                            : Image.file(_imageFile!)
                        : const Center(
                            child: Text('Press to select image'),
                          ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Upload.instance.uploadimage(file);
                    setState(() {
                      file == null;
                    });
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
