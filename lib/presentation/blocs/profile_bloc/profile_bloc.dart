import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:salesforce/data/models/userDetailsDataModel.dart';
import 'package:salesforce/domain/entities/userDetail.dart';
import 'package:salesforce/domain/entities/userDetailsData.dart';
import 'package:salesforce/domain/usecases/hiveUseCases/hiveUseCases.dart';
import 'package:salesforce/domain/usecases/usecasesForRemoteSource.dart';
import 'package:salesforce/error/failure.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/utils/hiveConstant.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  var useCaseForRemoteSourceimpl = getIt<UseCaseForRemoteSourceimpl>();
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
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

        /// get list of depot from the hive
        List<dynamic>? editProfileKeys;

        Box box = await Hive.openBox(HiveConstants.userdata);
        var failureOrSuccess = useCaseForHiveImpl.getAllValuesFromHiveBox(box);
        // getValuesByKey(box, HiveConstants.userdata);

        print(failureOrSuccess);

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
