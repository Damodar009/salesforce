import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:salesforce/presentation/blocs/Attendence_Bloc/attendence_cubit.dart';
import 'package:salesforce/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:salesforce/presentation/pages/dashboard.dart';
import 'package:salesforce/presentation/pages/login/loginScreen.dart';
import 'package:salesforce/routes.dart';
import 'package:salesforce/utils/appTheme.dart';
import 'package:salesforce/utils/hiveConstant.dart';
import 'domain/entities/attendence.dart';
import 'domain/entities/depot.dart';
import 'domain/entities/products.dart';
import 'domain/entities/retailerType.dart';
import 'domain/entities/saleslocationTrack.dart';
import 'domain/usecases/useCaseForAttebdenceSave.dart';
import 'domain/usecases/usecasesForRemoteSource.dart';
import 'injectable.dart';
import 'package:path_provider/path_provider.dart' as pathprovider;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection();
  final directory = await pathprovider.getApplicationDocumentsDirectory();
  // Hive.initFlutter());
  Hive.init(directory.path);

  Hive
    // ..initFlutter()
    ..init(directory.path)
    ..registerAdapter(AttendenceAdapter())
    ..registerAdapter(DepotAdapter())
    ..registerAdapter(ProductsAdapter())
    ..registerAdapter(RetailerTypeAdapter())
    ..registerAdapter(SalesLocationTrackAdapter());

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
    Box box = await Hive.openBox("salesForce");
    isLoggedIn = box.get("isLoggedIN", defaultValue: false);
  }

  @override
  void initState() {
    print("this is logged in") ;
     checkUserLoggedIn();
    super.initState();
  }

  var useCaseForRemoteSourceImpl = getIt<UseCaseForRemoteSourceimpl>();
  var useCaseForAttendenceImpl = getIt<UseCaseForAttendenceImpl>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(useCaseForRemoteSourceImpl)),
        BlocProvider(
            create: (context) => AttendenceCubit(useCaseForAttendenceImpl)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        title: 'SalesForce',
        theme: theme,
        initialRoute: Routes.splashScreen,
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;
  checkUserLoggedIn() async {

    print('checkign hive toek');
    final String checkUserAccessToken;

    try {
      Box box = await Hive.openBox(HiveConstants.userdata);
    } catch (e) {
      print(e);
    }
    Box box = await Hive.openBox(HiveConstants.userdata);
    

    // print(box.get("access_token"));

    checkUserAccessToken = await box.get("access_token");

    print('yoyr token is ');

    print(checkUserAccessToken);
    print('1234oleoleoleoleoleole');

    setState(() {
      print('yoou are inside setsatea');
      if (checkUserAccessToken.isNotEmpty) {
        print('you should be in dashboard');
        print('you have toekn');
        isLoggedIn = true;
      } else {
        isLoggedIn = false;
      }
    });

    print(isLoggedIn);
  }

  @override
  void initState() {
    print(' your are not log in ');
    checkUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('oleoleoleoleolele000');
    return isLoggedIn ? DashboardScreen(index: 0) : LOginScreen();
  }
}
