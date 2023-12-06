import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Upload extends GetxController {
  static Upload instance = Get.find();

  Reference referenceDirImage = FirebaseStorage.instance.ref().child('imagestest');

  late String imageUrl;

  Future<void> uploadImage(XFile? file) async {
    if (file == null) return;

    // Step 4: Create a unique name for the image
    String imageName = DateTime.now().microsecondsSinceEpoch.toString();

    // Step 2: Upload the image
    // Import storage library
    // To upload, we need a reference to the file, and to do that, we need to create the reference

    // Create a reference for the specific file we are uploading
    Reference referenceImageToUpload = referenceDirImage.child(imageName);

    try {
      if (kIsWeb) {
        await referenceImageToUpload
            .putData(
          await file.readAsBytes(),
          SettableMetadata(contentType: 'image/jpeg'),
        )
            .whenComplete(() async {
          imageUrl = await referenceImageToUpload.getDownloadURL();
          print('This is the URL: $imageUrl');

          Get.snackbar(
            "Upload Info",
            "Image upload successful",
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
          );
        });
      } else {
        await referenceImageToUpload.putFile(File(file.path)).whenComplete(() async {
          imageUrl = await referenceImageToUpload.getDownloadURL();
          print('This is the URL: $imageUrl');

          Get.snackbar(
            "Upload Info",
            "Image upload successful",
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
          );
        });
      }
    } catch (e) {
    

      Get.snackbar(
        "Upload Failed",
        e.toString(),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
      );
    }
  }
}
