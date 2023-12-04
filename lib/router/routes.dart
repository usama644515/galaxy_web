import 'dart:convert';
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:galaxy_web/components/contactUs.dart';
import 'package:galaxy_web/components/product_details.dart';
import 'package:galaxy_web/dashboard/DashBoardSection/main/main_screen.dart';
import 'package:galaxy_web/main/about_us.dart';
import 'package:galaxy_web/main/agents.dart';
import 'package:galaxy_web/main/blog.dart';
import 'package:galaxy_web/main/blogscreen.dart';
import 'package:galaxy_web/main/home.dart';
import 'package:galaxy_web/main/shop.dart';
import 'package:meta_seo/meta_seo.dart';

class RouteHandler {
  static final FluroRouter router = FluroRouter();

  static void defineRoutes() {
    router.define(
      '/',
      handler: Handler(handlerFunc: (context, parameters) {
        // Add MetaSEO just into Web platform condition
        // if (kIsWeb) {
        //   // Define MetaSEO object
        //   MetaSEO meta = MetaSEO();
        //   // add meta seo data for web app as you want
        //   meta.ogTitle(ogTitle: 'Galaxt Realtor Builder - Home');
        //   meta.description(
        //       description:
        //           "Explore Galaxy Realtor Builder's exceptional real estate projects that bring innovation and luxury to life. Discover your dream home among the stars. Contact us for exclusive property opportunities.");
        //   meta.keywords(
        //       keywords:
        //           'buch villas, buch villas multan, galaxy realtor, galaxy builder, buch, buch villa');
        // }
        return Home();
      }),
    );

    router.define(
      '/about',
      handler: Handler(handlerFunc: (context, parameters) => AboutUs()),
    );
    router.define(
      '/shop',
      handler: Handler(handlerFunc: (context, parameters) => Shop()),
    );
    router.define(
      '/dashboard',
      handler: Handler(handlerFunc: (context, parameters) => MainScreen()),
    );
    router.define(
      '/contactus',
      handler: Handler(handlerFunc: (context, parameters) => ContactUs()),
    );
    router.define(
      '/blog',
      handler: Handler(handlerFunc: (context, parameters) => Blog()),
    );
    router.define(
      '/agents',
      handler: Handler(handlerFunc: (context, parameters) => Agents()),
    );
    router.define(
      '/shop/:id', // Define a route with a parameter named 'id'
      handler: Handler(
        handlerFunc: (context, parameters) {
          // Parse the 'id' parameter
          // print(parameters['productdata']);
          var id = parameters['id']![0];
          // var data = parameters['productdata'];

          // Pass the parsed parameter to the AboutScreen
          return ProductDetails(
            id: id,
          );
          // id: dataId[index],
          //                                             data: data[index],
          //                                             shop: 'true'
        },
      ),
    );
    router.define(
      '/blog/:id', // Define a route with a parameter named 'id'
      handler: Handler(
        handlerFunc: (context, parameters) {
          // Parse the 'id' parameter
          // print(parameters['productdata']);
          var id = parameters['id']![0];
          // var data = parameters['productdata'];

          // Pass the parsed parameter to the AboutScreen
          return BlogScreen(
            data: id,
          );
          // id: dataId[index],
          //                                             data: data[index],
          //                                             shop: 'true'
        },
      ),
    );
    // Add more routes as needed
  }

  // Helper function to parse a Map from a JSON string
  static Map<String, dynamic> _parseMap(String jsonString) {
    try {
      return json.decode(jsonString);
    } catch (e) {
      print('Error parsing map: $e');
      return {};
    }
  }
}
