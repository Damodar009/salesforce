import 'package:flutter/material.dart';
import 'package:salesforce/presentation/pages/dashboard.dart';
import 'package:salesforce/presentation/pages/login/loginScreen.dart';
import 'package:salesforce/presentation/pages/profilePage.dart';

class Routes {
  static const String profileRoute = "/profile";
  static const String loginRoute = "/";
  static const String dashboardRoute = "/dashboard";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LOginScreen());
      case Routes.profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case Routes.dashboardRoute:
        return MaterialPageRoute(
            builder: (_) => DashboardScreen(
                  index: 0,
                ));

      default:
        return MaterialPageRoute(builder: (_) => const LOginScreen());
    }
  }
}
