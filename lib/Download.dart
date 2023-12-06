import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:storage/StorageController.dart';

class DownloadDataScreen extends StatefulWidget {
  const DownloadDataScreen({super.key});

  @override
  _DownloadDataScreenState createState() => _DownloadDataScreenState();
}

class _DownloadDataScreenState extends State<DownloadDataScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:   Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 20,
                  child: Text('Uploaded images will appear here'),
                ),
                Divider(),
                CircularProgressIndicator(),
              ],
            ),
          
    ));
  }
}




