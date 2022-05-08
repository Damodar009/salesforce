import 'package:flutter/material.dart';
import 'package:salesforce/presentation/pages/attendance_page.dart';
import 'package:salesforce/presentation/pages/dashboard.dart';
import 'package:salesforce/presentation/pages/editProfile.dart';
import 'package:salesforce/presentation/pages/listOfOrderAndOutlets.dart';
import 'package:salesforce/presentation/pages/logOutPage.dart';
import 'package:salesforce/presentation/pages/login/loginScreen.dart';
import 'package:salesforce/presentation/pages/newOrderPage.dart';
import 'package:salesforce/presentation/pages/newOutletsPage.dart';
import 'package:salesforce/presentation/pages/profilePage.dart';
import 'package:salesforce/presentation/pages/xlsOrderPage.dart';
import 'package:salesforce/presentation/widgets/visitedOutletWidget.dart';

class Routes {
  static const String profileRoute = "/profile";
  static const String loginRoute = "/";
  static const String dashboardRoute = "/dashboard";
  static const String attendanceRoute = "/attendance";
  static const String newOrderRoute = "/create/order";
  static const String newOutletsRoute = "/create/outlets";
  static const String salesDataCollection = "/sales/data-collection";
  static const String logOUtRoutes = "/logout";
  static const String totalOutletsRoute = "/totalOutlets";
  static const String newOutletRoute = "/newOutlet";
  static const String totalOutLetsVisitedRoute = "/totalOutLetsVisited";
  static const String totalSalesRoute = "/totalSales";
  static const String visitedOutlets = "/visitedOutlets";
  static const String xlsOrder = "/xlsOrder";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LOginScreen());
      case Routes.profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case Routes.newOrderRoute:
        return MaterialPageRoute(builder: (_) => const NewOrderScreen());
      case Routes.newOutletsRoute:
        return MaterialPageRoute(builder: (_) => const NewOutletsScreen());
      case Routes.salesDataCollection:
        return MaterialPageRoute(builder: (_) => Container());
      case Routes.logOUtRoutes:
        return MaterialPageRoute(builder: (_) => const LogOutPage());
      case Routes.dashboardRoute:
        return MaterialPageRoute(
            builder: (_) => DashboardScreen(
                  index: 0,
                ));
      case Routes.attendanceRoute:
        return MaterialPageRoute(builder: (_) => const AttendenceScreen());

      case Routes.totalOutletsRoute:
        return MaterialPageRoute(
            builder: (_) => ListOfOrderAndOutletDetailScreen());

      case Routes.newOutletRoute:
        return MaterialPageRoute(
            builder: (_) => ListOfOrderAndOutletDetailScreen());

      case Routes.totalOutLetsVisitedRoute:
        return MaterialPageRoute(
            builder: (_) => ListOfOrderAndOutletDetailScreen());

      case Routes.totalSalesRoute:
        return MaterialPageRoute(
            builder: (_) => ListOfOrderAndOutletDetailScreen());

      case Routes.xlsOrder:
        return MaterialPageRoute(builder: (_) => const XlsOrder());

      case Routes.visitedOutlets:
        if (args is VistedOutlets) {
          return MaterialPageRoute(
              builder: (_) => VisitedOutletWidget(visitedOutlets: args));
        } else {
          return MaterialPageRoute(builder: (_) => const UndefinedRoute());
        }
      default:
        return MaterialPageRoute(builder: (_) => const LOginScreen());
    }
  }
}

class UndefinedRoute extends StatelessWidget {
  const UndefinedRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("undefined route")),
    );
  }
}
