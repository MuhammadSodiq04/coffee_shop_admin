import 'package:coffee_shop_admin/data/model/coffee_model.dart';
import 'package:coffee_shop_admin/ui/route/route_names.dart';
import 'package:coffee_shop_admin/ui/tab_admin/coffees/sub_screens/coffee_add_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.coffeeAdd:
        return MaterialPageRoute(builder: (_) =>  CoffeeAddScreen(coffeeModel: settings.arguments as CoffeeModel?));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}