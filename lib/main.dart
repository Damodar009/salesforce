import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:salesforce/presentation/blocs/Attendence_Bloc/attendence_cubit.dart';
import 'package:salesforce/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:salesforce/routes.dart';
import 'package:salesforce/utils/appTheme.dart';
import 'domain/entities/attendence.dart';
import 'domain/entities/depot.dart';
import 'domain/entities/products.dart';
import 'domain/entities/retailerType.dart';
import 'domain/entities/saleslocationTrack.dart';
import 'domain/usecases/hiveUseCases/hiveUseCases.dart';
import 'domain/usecases/useCaseForAttebdenceSave.dart';
import 'domain/usecases/usecasesForRemoteSource.dart';
import 'injectable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection();

  Hive
    ..initFlutter()
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
    var box = await Hive.openBox("salesForce");
    isLoggedIn = box.get("isLoggedIN", defaultValue: false);
  }

  @override
  void initState() {
    //  checkUserLoggedIn();
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
        initialRoute:  Routes.dashboardRoute,
      ),
    );
  }
}
