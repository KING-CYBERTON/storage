
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:storage/StorageController.dart';

class DownloadDataScreen extends StatefulWidget {
  const DownloadDataScreen({super.key});

  @override
  _DownloadDataScreenState createState() => _DownloadDataScreenState();
}

class _DownloadDataScreenState extends State<DownloadDataScreen> {
  
  late Future<ListResult> imagefiles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagefiles = Upload.instance.referenceDirImage.listAll();
  }
  Future<void> deleteAndRefreshList(Reference imageRef) async {
    try {
      // Delete the file
      await imageRef.delete();
      print('File deleted successfully');

      // Refresh the list by fetching updated data
      setState(() {
        imagefiles = Upload.instance.referenceDirImage.listAll();
      });
    } catch (e) {
      print('Error deleting file: $e');
    }
  }

   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  const Center(
            child: CircularProgressIndicator(),
          
    ));
  }
}




