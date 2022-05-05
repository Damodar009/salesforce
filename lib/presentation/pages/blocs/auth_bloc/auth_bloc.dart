import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/data/datasource/hive.dart';
import 'package:salesforce/domain/usecases/usecasesForRemoteSource.dart';
import 'package:salesforce/error/failure.dart';
import 'package:salesforce/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  SaveLocally hiveDb = SaveLocally();
  var useCaseForRemoteSourceimpl = getIt<UseCaseForRemoteSourceimpl>();

  AuthBloc(this.useCaseForRemoteSourceimpl) : super(AuthInitial()) {
    on<LoginAttemptEvent>((event, emit) async {
      emit(LoginLoadingState());
      final isSuccessful = await useCaseForRemoteSourceimpl.login(
          event.username, event.password);

      isSuccessful.fold(
          (l) => {
                print("This is the server failure "),
                if (l is ServerFailure)
                  emit(LoginFailedState())
                else if (l is CacheFailure)
                  emit(LoginFailedState())
              },
          (r) => emit(LoginSuccessState()));
    });

    on<ChangePasswordEvent>((event, emit) async {
      emit(ChangePasswordLoadingState());
      final isSuccessful = await useCaseForRemoteSourceimpl.changePassword(
          event.oldPassword, event.newPassword);

      isSuccessful.fold(
          (l) => {
                print("This is the server failure "),
                if (l is ServerFailure)
                  emit(ChangePasswordFailedState())
                else if (l is CacheFailure)
                  emit(ChangePasswordFailedState())
              },
          (r) => emit(ChangePasswordSuccessState()));
    });
  }

  // AuthBloc({required this.useCaseForRemoteSourceimpl}) : super(AuthInitial());

  // Stream<AuthState> mapEventToStateLoginAttempt(AuthEvent event) async* {
  //   if (event is LoginAttemptEvent) {
  //     print("AuthEvent : called");
  //     yield LoadingState();
  //     final loginFailedOrSuccess = await useCaseForRemoteSourceimpl.login(
  //         event.username, event.password);
  //     yield loginFailedOrSuccess.fold(
  //         (l) => LoginFailedState(), (r) => LoginSuccessState());
  //   }
  // }

  // Stream<AuthState> mapEventToStateChangePassword(AuthEvent event) async* {
  //   if (event is ChangePasswordEvent) {
  //     Box box = await hiveDb.openBox();

  //     Box acessToken = box.get('acess_token');

  //     print("AuthEvent : called");

  //     if (box.isNotEmpty) {
  //       yield LoadingState();
  //       final changePasswordFailedOrSuccess =
  //           await useCaseForRemoteSourceimpl.changePassword(
  //         event.oldPassword,
  //         event.newPassword,
  //       );
  //       yield changePasswordFailedOrSuccess.fold(
  //           (l) => ChangePasswordFailedState(),
  //           (r) => ChangePasswordSuccessState());
  //     }
  //   }
  // }

  // Stream<AuthState> mapEventToStateResetPassword(AuthEvent event) async* {
  //   if (event is ResetPasswordEvent) {
  //     print("AuthEvent : called");
  //     yield LoadingState();
  //     final resetPasswordFailedOrSuccess =
  //         await useCaseForRemoteSourceimpl.resetPassword();
  //     yield resetPasswordFailedOrSuccess.fold((l) => ResetPasswordFailedState(),
  //         (r) => ResetPasswordSuccessState());
  //   }
  // }

  // @override
  // void onTransition(Transition<AuthEvent, AuthState> transition) {
  //   print("AuthBloc : $transition");
  //   super.onTransition(transition);
  // }
}
