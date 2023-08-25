import 'dart:html';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:storage/StorageController.dart';
import 'package:path_provider/path_provider.dart';

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
        body: FutureBuilder(
      future: imagefiles,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.items.length,
              itemBuilder: (context, index) {
                final imageRef = snapshot.data!.items[index];

                return  Row(
    children: [
      FutureBuilder<String>(
        future: imageRef.getDownloadURL(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return
            
             Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Image.network(
                        snapshot.data!,
                        width: 400,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        color: Colors.amber,
                        onPressed: () async {
                          final url = snapshot.data!;
                          if (kIsWeb) {
                            window.open(url, '_blank');
                          } else {
                            final tempfile = await getTemporaryDirectory();
                            final path = '${tempfile.path}/${imageRef.name}';
                            await Dio().download(url, path);
                            await GallerySaver.saveImage(path, toDcim: true);
                          }
                        },
                        icon: const Icon(Icons.download_outlined),
                      ),
                    ),
                  ],
                ),
              ],
            );
       
          } else {
            return const Text('Image not available.');
          }
        },
      ),
      const Spacer(),
      Column(
        children: [
          ElevatedButton(
            onPressed: () async {
            },
            child: Text('Delete File'),
          ),
          Text(imageRef.name),
        ],
      ),
    ],
  );
              });
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Unepected error found\n $e'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}




