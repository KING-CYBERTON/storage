import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: camel_case_types
class Upload extends GetxController {
  static Upload instance = Get.find();

  Reference referenceDirImage = FirebaseStorage.instance.ref().child('imagestest');

  late String imageUrl;

  Future<void> uploadimage(XFile? file) async {
    if (file == null) return;
    //step 4 create unique name for image
    String imageName = DateTime.now().microsecondsSinceEpoch.toString();

    //steep two is to upload the image.
    //import storage libray
    //to ipload we need a reference of the file and to do that we need to create the reference

    //create a reference for the specific file we are uploading
    Reference referenceImagetoUpload = referenceDirImage.child(imageName);

    try {
      if (kIsWeb) {
           await referenceImagetoUpload
         .putData(
      await file.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    )
          .whenComplete(() => {
                imageUrl = referenceImagetoUpload.getDownloadURL().toString(),
                print('this is the url  $imageUrl'),
              });
      //if succesfull get url
      imageUrl = await referenceImagetoUpload.getDownloadURL();
      print('this is the url$imageUrl');
} else { 
       await referenceImagetoUpload
      .putFile(File(file.path))
      .whenComplete(() => {
            imageUrl = referenceImagetoUpload.getDownloadURL().toString(),
            print('this is the url$imageUrl'),
          });
  //if succesfull get url
  imageUrl = await referenceImagetoUpload.getDownloadURL();
  print('this is the url$imageUrl');
}
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> downloadimage(String imageName)async {
      
      Reference referenceImagetoDownload = referenceDirImage.child(imageName);
    
    

  }
}
