import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salesforce/presentation/pages/dashboard.dart';
import 'package:salesforce/presentation/pages/login/loginScreen.dart';
import 'package:salesforce/utils/appTheme.dart';
import 'injectable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection();
  var path = Directory.current.path;
  Hive.init(path);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MayApp();
  }
}

class MayApp extends StatefulWidget {
  const MayApp({Key? key}) : super(key: key);

  @override
  State<MayApp> createState() => _MayAppState();
}

class _MayAppState extends State<MayApp> {
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SalesForce',
        theme: theme,
        home: isLoggedIn
            ? DashboardScreen(
                index: 0,
              )
            : const LOginScreen());
  }
}
