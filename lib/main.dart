import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_web/controllers/MenuController.dart';
import 'package:galaxy_web/main/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'router/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyC7cbB1HJEYhR80yWnDJUDEJWxXkQnnepM",
        projectId: "galaxy-realtors-builders",
        storageBucket: "galaxy-realtors-builders.appspot.com",
        messagingSenderId: "216059000449",
        appId: "1:216059000449:web:3c909ced665996854abf80",
      ),
    );
  } else {
    // await Firebase.initializeApp();
  }
  final router = FluroRouter();
  Routes.configureRoutes(router); // Configure your routes
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => menuController(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Galaxy Realtors Builders',
        home: Home(),
      ),
    );
  }
}
