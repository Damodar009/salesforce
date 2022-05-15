import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesforce/data/models/userDetailsDataModel.dart';
import 'package:salesforce/domain/entities/userDetail.dart';
import 'package:salesforce/domain/entities/userDetailsData.dart';
import 'package:salesforce/domain/usecases/usecasesForRemoteSource.dart';
import 'package:salesforce/error/failure.dart';
import 'package:salesforce/injectable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  var useCaseForRemoteSourceimpl = getIt<UseCaseForRemoteSourceimpl>();
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetProfileEvent>(
      (event, emit) async {
        emit(GetProfileLoadingState());

        final isSuccessful =
            await useCaseForRemoteSourceimpl.getUserDetailsData();

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(GetProfileFailedState());
          } else if (l is CacheFailure) {
            emit(GetProfileFailedState());
          }
        }, (r) {
          emit(GetProfileLoadedState(userDetailsdata: r));
        });
      },
    );

    on<SaveUserDetailsEvent>(
      (event, emit) async {
        emit(SaveUserDetailsLoadingState());

        final isSuccessful =
            await useCaseForRemoteSourceimpl.saveUserDetails(event.userDetails);

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(SaveUserDetailsFailedState());
          } else if (l is CacheFailure) {
            emit(SaveUserDetailsFailedState());
          }
        }, (r) => emit(SaveUserDetailsLoadedState()));
      },
    );
  }
}
