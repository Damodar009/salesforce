import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:salesforce/presentation/pages/blocs/auth_bloc/auth_bloc.dart';
import 'package:salesforce/presentation/pages/dashboard.dart';
import 'package:salesforce/presentation/pages/login/loginScreen.dart';
import 'package:salesforce/routes.dart';
import 'package:salesforce/utils/appTheme.dart';
import 'injectable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection();
  var path = Directory.current.path;
  Hive.init(path);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = true;
  checkUserLoggedIn() async {
    var box = await Hive.openBox("salesForce");
    isLoggedIn = box.get("isLoggedIN", defaultValue: false);
  }

  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthBloc>()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.getRoute,
          title: 'SalesForce',
          theme: theme,
          home: isLoggedIn
              ? DashboardScreen(
                  index: 0,
                )
              : const LOginScreen()),
    );
  }
}
