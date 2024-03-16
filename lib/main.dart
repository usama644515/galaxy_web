import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_web/components/contactUs.dart';
import 'package:galaxy_web/components/product_details.dart';
import 'package:galaxy_web/components/search_screen.dart';
import 'package:galaxy_web/controllers/MenuController.dart';
import 'package:galaxy_web/main/about_us.dart';
import 'package:galaxy_web/main/agencyScreen.dart';
import 'package:galaxy_web/main/agent_create.dart';
import 'package:galaxy_web/main/blog.dart';
import 'package:galaxy_web/main/bottomBar.dart';
import 'package:galaxy_web/main/home.dart';
import 'package:galaxy_web/router/routes.dart';
import 'package:galaxy_web/welcome/signin.dart';
import 'package:galaxy_web/welcome/signup.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:provider/provider.dart';
import 'package:seo_renderer/seo_renderer.dart';
import 'dashboard/DashBoardSection/main/main_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'dart:html' as html;
import 'package:go_router/go_router.dart';

import 'main/agents.dart';
import 'main/blogscreen.dart';
import 'main/shop.dart';
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
        // authDomain: "galaxyrealtor.pk",
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
  // Initialize the router
  // RouteHandler.defineRoutes();
  // Initialize the router for web
  // FluroRouter.setupRouter();
  if (kIsWeb) {
    MetaSEO().config();
  }
  runApp(MyApp());
  // Listen to changes in the URL
  // html.window.onPopState.listen((html.Event e) {
  //   final String? path = html.window.location.pathname;
  //   setNewRoutePath(path!);
  //   // print(path);

  // });
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void setNewRoutePath(String path) {
  navigatorKey.currentState?.pushReplacementNamed(path);
}

// GoRouter configuration
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name:
          'Home', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/',
      builder: (context, state) {
        // Add MetaSEO just into Web platform condition
        if (kIsWeb) {
          // Define MetaSEO object
          MetaSEO meta = MetaSEO();
          // add meta seo data for web app as you want
          meta.ogTitle(ogTitle: 'Pretorian Realtor Builder - Home');
          meta.description(
              description:
                  "Explore Pretorian Realtor Builder's exceptional real estate projects that bring innovation and luxury to life. Discover your dream home among the stars. Contact us for exclusive property opportunities.");
          meta.keywords(
              keywords:
                  'buch villas, buch villas multan, galaxy realtor, galaxy builder, buch, buch villa, Pretorian Realtor Builder, houses for sale, house for sale, royal orchard, multan, dha multan, dha, plots for sale, plots in multan');
        }
        return Home();
      },
    ),
    GoRoute(
      name:
          'Shop', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/shop',
      builder: (context, state) => Shop(),
    ),
    GoRoute(
      name:
          'Dashboard', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/dashboard',
      builder: (context, state) => MainScreen(),
    ),
    GoRoute(
      name:
          'About', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/about',
      builder: (context, state) => AboutUs(),
    ),
    GoRoute(
      name:
          'Blog', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/blog',
      builder: (context, state) => Blog(),
    ),
    GoRoute(
      name:
          'Agents', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/agents',
      builder: (context, state) => Agents(),
    ),
    GoRoute(
      name: 'Contact us',
      path: '/contactus',
      builder: (context, state) => ContactUs(),
    ),
    GoRoute(
      name: 'Login',
      path: '/login',
      builder: (context, state) => SignIn(),
    ),
    GoRoute(
      name: 'Sign Up',
      path: '/singup',
      builder: (context, state) => SignUp(),
    ),
    GoRoute(
      name: 'Search',
      path: '/search',
      builder: (context, state) => SearchScreen(),
    ),
    GoRoute(
      name: 'Create Agent',
      path: '/create-agent',
      builder: (context, state) => AgentCreate(),
    ),
    GoRoute(
      path: '/agents/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']; // Get "id" param from URL
        return AgencyScreen(id: id);
      },
    ),
    GoRoute(
      path: '/shop/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']; // Get "id" param from URL
        return ProductDetails(id: id);
      },
    ),
    GoRoute(
      path: '/blog/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']; // Get "id" param from URL
        return BlogScreen(data: id);
      },
    ),
  ],
);

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
        child: MaterialApp.router(
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
          title: 'Pretorian Realtor Builder',
          // home: kIsWeb ? Home() : Bar(ind: 0),
          // navigatorObservers: [seoRouteObserver],
          // onGenerateRoute: RouteHandler.router.generator,
          // navigatorKey: navigatorKey,
        ),
      ),
    );
  }
}
