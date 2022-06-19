
import 'package:flutter/material.dart';
import 'package:marvel_task/screens/characters_screen.dart';

import 'string_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String characterScreen = AppStrings.characterScreenRouteName;
  
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case Routes.splashRoute:
      //   return MaterialPageRoute(builder: (_) => const SplachScreen());
     case Routes.characterScreen:
        return MaterialPageRoute(builder: (_) => const CharactersScreen());
        default:
          return unDefinedRoute();
    }
  }
  
  static Route<dynamic> unDefinedRoute() {
 return MaterialPageRoute(
      builder: (_) => Scaffold(
             appBar: AppBar(
               title: const Text(AppStrings.noRouteFound),
             ),
             body: const Center(child: Text(AppStrings.noRouteFound)),
           ));
}
}