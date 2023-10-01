import 'package:fluro/fluro.dart';

import '../main/shop.dart';

class Routes {
  static String root = "/shop";
  static String customRoute = "/custom/:id"; // Define your custom route

  static void configureRoutes(FluroRouter router) {
    router.define(root, handler: _shopHandler);
    // router.define(customRoute, handler: customRouteHandler);
  }

  static final Handler _shopHandler = Handler(
    handlerFunc: (context, params) {
      return const Shop();
    },
  );
}
