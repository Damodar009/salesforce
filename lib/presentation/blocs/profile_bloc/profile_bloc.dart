import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesforce/data/models/SaveUserDetailsDataModel.dart';
import 'package:salesforce/data/models/saveUserDetailsModel.dart';
import 'package:salesforce/data/models/userDetailModel.dart';
import 'package:salesforce/domain/entities/userDetailsData.dart';
import 'package:salesforce/domain/usecases/hiveUseCases/hiveUseCases.dart';
import 'package:salesforce/domain/usecases/usecasesForRemoteSource.dart';
import 'package:salesforce/domain/usecases/userCaseForUploadImageSave.dart';
import 'package:salesforce/error/failure.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/presentation/blocs/upload_image/upload_image_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  var useCaseForRemoteSourceimpl = getIt<UseCaseForRemoteSourceimpl>();
  var useCaseForUploadImageImpl = getIt<UseCaseForUploadImageImpl>();
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();

  // final UploadImageBloc uploadImageBloc;
  late final StreamSubscription uploadImageStreamSubscription;

  ProfileBloc(

  ) : super(ProfileInitial()) {
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
        print("you are in bloc hai tah kta ho ");

        final isSuccessful =
            await saveEditProfileDatas(event.saveUserDetailsDataModel);

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

  saveEditProfileDatas(SaveUserDetailsDataModel user) async {
    print(user.toJson());

    print("you are inside the function");
    if (user.userDetail!.userDocument != null) {
      print("images ");
      String imageId = "";
      final isSuccesfull = await useCaseForUploadImageImpl
          .uploadImageSave(user.userDetail!.userDocument!);

      isSuccesfull.fold(
          (l) => {print("sad")},
          (r) => {
                imageId = r.toString(),
                print("inside image upload "),
                print(user.userDetail!.user_detail_id)
              });

      SaveUserDetailsDataModel saveUserDetailsDataModelData =
          SaveUserDetailsDataModel(
              id: user.id,
              roleId: user.roleId,
              email: user.email,
              roleName: user.roleName,
              phoneNumber: user.phoneNumber,
              userDetail: UserDetailsModel(
                  id: user.userDetail!.id,
                  fullName: user.userDetail!.fullName,
                  gender: user.userDetail!.gender,
                  dob: user.userDetail!.dob,
                  permanentAddress: user.userDetail!.permanentAddress,
                  temporaryAddress: user.userDetail!.temporaryAddress,
                  contactNumber2: user.userDetail!.contactNumber2,
                  userDocument: imageId));

      print("user detail model");
      print(saveUserDetailsDataModelData.toJson());

      saveEditProfileDataWithoutImage(saveUserDetailsDataModelData);
      //implement code to post image
    } else {
      print("you are in else");
      saveEditProfileDataWithoutImage(user);

      // implement code to send data
    }
  }

  saveEditProfileDataWithoutImage(SaveUserDetailsDataModel user) async {
    print("heloo whay are you donh");
    final isSuccesfull = await useCaseForRemoteSourceimpl.saveUserDetails(user);

    isSuccesfull.fold((l) {
      if (l is ServerFailure) {
        print("l is ServerFailure");
        emit(SaveUserDetailsFailedState());
      } else if (l is CacheFailure) {
        print("l is CacheFailure");
        emit(SaveUserDetailsFailedState());
      }
    }, (r) {
      emit(SaveUserDetailsLoadedState());
    });
  }
}
