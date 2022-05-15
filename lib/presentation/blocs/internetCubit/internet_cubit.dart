import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  InternetCubit() : super(InternetLoading()) {
    monitorInternetConnection();
  }
  StreamSubscription? connectivityStreamSubscription;

  StreamSubscription monitorInternetConnection() {
    final StreamSubscription<InternetConnectionStatus>
        connectivityStreamSubscription =
        InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            emitInternetConnected();
            print('Data connection is available.');
            break;
          case InternetConnectionStatus.disconnected:
            emitInternetDisconnected();
            print('You are disconnected from the internet.');
            break;
        }
      },
    );
    return connectivityStreamSubscription;
  }

  void emitInternetConnected() => emit(InternetConnected());

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription?.cancel();
    return super.close();
  }
}
