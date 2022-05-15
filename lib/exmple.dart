// enum ConnectionType {
//   Wifi,
//   Mobile,
// }

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'package:flutter_bloc_concepts/logic/cubit/counter_cubit.dart';
// import 'package:flutter_bloc_concepts/presentation/router/app_router.dart';
//
// import 'logic/cubit/internet_cubit.dart';
//
// void main() {
//   runApp(MyApp(
//     appRouter: AppRouter(),
//     connectivity: Connectivity(),
//   ));
// }
//
// class MyApp extends StatelessWidget {
//   final AppRouter appRouter;
//   final Connectivity connectivity;
//
//   const MyApp({
//     Key key,
//     @required this.appRouter,
//     @required this.connectivity,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<InternetCubit>(
//           create: (context) => InternetCubit(connectivity: connectivity),
//         ),
//         BlocProvider<CounterCubit>(
//           create: (context) => CounterCubit(),
//         ),
//       ],
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         onGenerateRoute: appRouter.onGenerateRoute,
//       ),
//     );
//   }
// }

// import 'package:bloc/bloc.dart';
//
// import 'package:meta/meta.dart';
//
// part 'counter_state.dart';
//
// class CounterCubit extends Cubit<CounterState> {
//   CounterCubit() : super(CounterState(counterValue: 0));
//
//   void increment() => emit(
//       CounterState(counterValue: state.counterValue + 1, wasIncremented: true));
//
//   void decrement() => emit(CounterState(
//       counterValue: state.counterValue - 1, wasIncremented: false));
// }

// part of 'counter_cubit.dart';
//
// class CounterState {
//   int counterValue;
//   bool wasIncremented;
//
//   CounterState({
//     @required this.counterValue,
//     this.wasIncremented,
//   });
// }

// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter_bloc_concepts/constants/enums.dart';
// import 'package:meta/meta.dart';
//
// part 'internet_state.dart';
//
// class InternetCubit extends Cubit<InternetState> {
//   final Connectivity connectivity;
//   StreamSubscription connectivityStreamSubscription;
//
//   InternetCubit({@required this.connectivity}) : super(InternetLoading()) {
//     monitorInternetConnection();
//   }
//
//   StreamSubscription<ConnectivityResult> monitorInternetConnection() {
//     return connectivityStreamSubscription =
//         connectivity.onConnectivityChanged.listen((connectivityResult) {
//           if (connectivityResult == ConnectivityResult.wifi) {
//             emitInternetConnected(ConnectionType.Wifi);
//           } else if (connectivityResult == ConnectivityResult.mobile) {
//             emitInternetConnected(ConnectionType.Mobile);
//           } else if (connectivityResult == ConnectivityResult.none) {
//             emitInternetDisconnected();
//           }
//         });
//   }
//
//   void emitInternetConnected(ConnectionType _connectionType) =>
//       emit(InternetConnected(connectionType: _connectionType));
//
//   void emitInternetDisconnected() => emit(InternetDisconnected());
//
//   @override
//   Future<void> close() {
//     connectivityStreamSubscription.cancel();
//     return super.close();
//   }
// }

// part of 'internet_cubit.dart';
//
// @immutable
// abstract class InternetState {}
//
// class InternetLoading extends InternetState {}
//
// class InternetConnected extends InternetState {
//   final ConnectionType connectionType;
//
//   InternetConnected({@required this.connectionType});
// }
//
// class InternetDisconnected extends InternetState {}
// var subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
//   if(result != ConnectivityResult.none) {
//     isDeviceConnected = await InternetConnectionChecker().hasConnection;
//   }
// });