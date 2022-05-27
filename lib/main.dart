import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:salesforce/data/datasource/local_data_sources.dart';
import 'package:salesforce/data/models/Userdata.dart';
import 'package:salesforce/domain/entities/merchandise.dart';
import 'package:salesforce/domain/entities/region.dart';
import 'package:salesforce/domain/usecases/hiveUseCases/hiveUseCases.dart';
import 'package:salesforce/domain/usecases/userCaseForUploadImageSave.dart';
import 'package:salesforce/presentation/blocs/Attendence_Bloc/attendence_cubit.dart';
import 'package:salesforce/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:salesforce/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:salesforce/presentation/blocs/upload_image/upload_image_bloc.dart';
import 'package:salesforce/presentation/pages/dashboard.dart';
import 'package:salesforce/presentation/pages/login/loginScreen.dart';
import 'package:salesforce/routes.dart';
import 'package:salesforce/utils/appTheme.dart';
import 'package:salesforce/utils/hiveConstant.dart';
import 'domain/entities/attendence.dart';
import 'domain/entities/depot.dart';
import 'domain/entities/products.dart';
import 'domain/entities/retailer.dart';
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
    ..registerAdapter(SalesLocationTrackAdapter())
    ..registerAdapter(MerchandiseDropDownAdapter())
    ..registerAdapter(RegionDropDownAdapter())
    ..registerAdapter(RetailerAdapter());

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
    print("this is logged in");
    // checkUserLoggedIn();
    super.initState();
  }

  var useCaseForRemoteSourceImpl = getIt<UseCaseForRemoteSourceimpl>();
  var useCaseForAttendenceImpl = getIt<UseCaseForAttendenceImpl>();
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  var useCaseForUploadImageImpl = getIt<UseCaseForUploadImageImpl>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(useCaseForRemoteSourceImpl)),
        BlocProvider(
            create: (context) => AttendenceCubit(useCaseForAttendenceImpl)),
        BlocProvider(
            create: (context) =>
                ProfileBloc(useCaseForRemoteSourceImpl, useCaseForHiveImpl)),
        BlocProvider(
            create: (context) => UploadImageBloc(useCaseForUploadImageImpl)),
        // BlocProvider(
        //   create: (context) => ),
        // ),
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
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  final signInLocalDataSource = getIt<SignInLocalDataSource>();

  bool isLoggedIn = false;
  checkUserLoggedIn() async {
    try {
      // String? accessToken;

      // Box box = await Hive.openBox(HiveConstants.userdata);

      // var checkUserAccessToken =
      //     useCaseForHiveImpl.getValueByKey(box, "access_token");

      // checkUserAccessToken.fold((l) => {print("failed")},
      //     (r) => {accessToken = r!, print(r.toString())});

      // currentUserInfo.
      print("this below is access toke hai ");
      print("this is main page and the keys are below");

      UserDataModel? userInfo =
          await signInLocalDataSource.getUserDataFromLocal();
      print(userInfo!.access_token);

      setState(() {
        if (userInfo.access_token != null) {
          isLoggedIn = true;
        } else {
          isLoggedIn = false;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? DashboardScreen(index: 0) : LOginScreen();
  }
}
