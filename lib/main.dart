import 'package:flutter/material.dart';
import 'package:galaxy_web/controllers/MenuController.dart';
import 'package:galaxy_web/main/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // await Firebase.initializeApp(
    //   options: const FirebaseOptions(
    //     apiKey: "AIzaSyAzKh07hDKkOWsPaLWCOAiY83XkhG9Zc_4",
    //     projectId: "pretorian-realtors-builders",
    //     storageBucket: "pretorian-realtors-builders.appspot.com",
    //     messagingSenderId: "562421234036",
    //     appId: "1:562421234036:web:45f5267765742649565421",
    //   ),
    // );
  } else {
    // await Firebase.initializeApp();
  }
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
        title: 'Website',
        home: Home(),
      ),
    );
  }
}

