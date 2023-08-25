import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storage/Download.dart';
import 'package:storage/StorageController.dart';
import 'package:storage/upload.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAmOB_-8DIEIwJEOvrM2a8C6RE-KbvSDDc",
        projectId: "educative-9",
        storageBucket: "educative-9.appspot.com",
        messagingSenderId: "14205101883",
        appId: "1:14205101883:web:49043452fcfe80de10791e",
      ),
    );
    runApp( MyApp());
  } else {
    await Firebase.initializeApp();
    runApp( MyApp());
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
       debugShowCheckedModeBanner: false,
      home: home(),
    );
  }
}

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with SingleTickerProviderStateMixin {
  final upload = Get.put(Upload());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Storage'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Upload'),
            Tab(text: 'Downloads'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [ PostDataScreen(),DownloadDataScreen(),],
      ),
    );
  }
}

