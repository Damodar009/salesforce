import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart' as pathprovider;
import 'package:salesforce/data/datasource/local_data_sources.dart';
import 'package:salesforce/data/models/Userdata.dart';
import 'package:salesforce/domain/entities/productName.dart';
import 'package:salesforce/domain/entities/publish_notification.dart';
import 'package:salesforce/domain/entities/requestedDropDown.dart';
import 'package:salesforce/presentation/blocs/Attendence_Bloc/attendence_cubit.dart';
import 'package:salesforce/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:salesforce/presentation/blocs/newOrdrBloc/new_order_cubit.dart';
import 'package:salesforce/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:salesforce/presentation/blocs/publish_notification/publish_notification_bloc.dart';
import 'package:salesforce/presentation/blocs/upload_image/upload_image_bloc.dart';
import 'package:salesforce/presentation/pages/dashboard.dart';
import 'package:salesforce/presentation/pages/login/loginScreen.dart';
import 'package:salesforce/routes.dart';
import 'package:salesforce/utils/appTheme.dart';
import 'package:salesforce/utils/geolocation.dart';
import 'package:salesforce/utils/initialData.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/entities/SalesData.dart';
import 'domain/entities/attendence.dart';
import 'domain/entities/availability.dart';
import 'domain/entities/depot.dart';
import 'domain/entities/merchandise.dart';
import 'domain/entities/merchndiseOrder.dart';
import 'domain/entities/paymentType.dart';
import 'domain/entities/products.dart';
import 'domain/entities/region.dart';
import 'domain/entities/requestDeliver.dart';
import 'domain/entities/retailer.dart';
import 'domain/entities/retailerDropDown.dart';
import 'domain/entities/retailerType.dart';
import 'domain/entities/returns.dart';
import 'domain/entities/sales.dart';
import 'domain/entities/saleslocationTrack.dart';
import 'domain/usecases/useCaseTosendAllLocalData.dart';
import 'injectable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection();
  final directory = await pathprovider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive
    ..init(directory.path)
    ..registerAdapter(AttendenceAdapter())
    ..registerAdapter(DepotAdapter())
    ..registerAdapter(ProductsAdapter())
    ..registerAdapter(RetailerTypeAdapter())
    ..registerAdapter(SalesLocationTrackAdapter())
    ..registerAdapter(RetailerAdapter())
    ..registerAdapter(SalesDataAdapter())
    ..registerAdapter(AvailabilityAdapter())
    ..registerAdapter(MerchandiseOrderAdapter())
    ..registerAdapter(ReturnsAdapter())
    ..registerAdapter(RetailerDropDownAdapter())
    ..registerAdapter(RegionDropDownAdapter())
    ..registerAdapter(SalesAdapter())
    ..registerAdapter(MerchandiseDropDownAdapter())
    ..registerAdapter(PublishNotificationAdapter())
    ..registerAdapter(ProductNameAdapter())
    ..registerAdapter(RequestedDropDownAdapter())
    ..registerAdapter(RequestDeliveredAdapter())
    ..registerAdapter(PaymentTypeAdapter());

  var geolocator = getIt<GeoLocationData>();
  await geolocator.checkLocationPermission();

  final StreamSubscription<InternetConnectionStatus> listener =
      InternetConnectionChecker().onStatusChange.listen(
    (InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          var localDataSend = AllLocalDataToApi();
          localDataSend.getAllDatFromApiAndSend();
          final InitialData _initialData = InitialData();
          _initialData.getAndSaveInitalData();
          break;

        case InternetConnectionStatus.disconnected:
          break;
      }
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = true;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => AttendenceCubit()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => UploadImageBloc()),
        BlocProvider(
            create: (context) => PublishNotificationBloc()
              ..add(GetAllPublishNotificationEvent())),
        BlocProvider(create: (context) => NewOrderCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        title: 'SalesForce',
        theme: theme,
        home: SplashScreen(),
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
  final signInLocalDataSource = getIt<SignInLocalDataSource>();

  bool? isLoggedIn;
  checkUserLoggedIn() async {
    try {
      UserDataModel? userInfo =
          await signInLocalDataSource.getUserDataFromLocal();
      setState(() {
        if (userInfo != null) {
          if (userInfo.access_token != null) {
            isLoggedIn = true;
          } else {
            isLoggedIn = false;
          }
        } else {
          isLoggedIn = false;
        }
      });
    } catch (e) {}
  }

  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn != null
        ? isLoggedIn!
            ? DashboardScreen(index: 0)
            : const LOginScreen()
        : Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  repeat: ImageRepeat.repeat,
                  image: AssetImage(
                    'assets/images/Splash.png',
                  ),
                ),
              ),
            ),
          );
  }
}
