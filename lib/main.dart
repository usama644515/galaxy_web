import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_web/controllers/MenuController.dart';
import 'package:galaxy_web/main/bottomBar.dart';
import 'package:galaxy_web/main/home.dart';
import 'package:provider/provider.dart';
import 'package:seo_renderer/seo_renderer.dart';
import 'firebase_options.dart';
// import 'router/routes.dart';

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
        authDomain: "galaxy-realtors-builders.firebaseapp.com",
      ),
    );
  } else if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    // await Firebase.initializeApp();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyC7cbB1HJEYhR80yWnDJUDEJWxXkQnnepM",
        projectId: "galaxy-realtors-builders",
        storageBucket: "galaxy-realtors-builders.appspot.com",
        messagingSenderId: "216059000449",
        appId: "1:216059000449:web:3c909ced665996854abf80",
      ),
    );
  }
  // final router = FluroRouter();
  // Routes.configureRoutes(router); // Configure your routes
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
      child: RobotDetector(
        debug: true, // you can set true to enable robot mode
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Galaxy Realtors Builders',
          home: kIsWeb ? Home() : Bar(ind: 0),
          navigatorObservers: [seoRouteObserver],
        ),
      ),
    );
  }
}
