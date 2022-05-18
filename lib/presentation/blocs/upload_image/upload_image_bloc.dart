import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesforce/domain/entities/image.dart';
import 'package:salesforce/domain/usecases/userCaseForUploadImageSave.dart';
import 'package:salesforce/error/failure.dart';
import 'package:salesforce/injectable.dart';

part 'upload_image_event.dart';
part 'upload_image_state.dart';

class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  var useCaseForUploadImageImpl = getIt<UseCaseForUploadImageImpl>();
  UploadImageBloc(this.useCaseForUploadImageImpl)
      : super(UploadImageInitial()) {
    on<UploadImageEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SaveImageEvent>(
      (event, emit) async {
        final isSuccesfull =
            await useCaseForUploadImageImpl.uploadImageSave(event.imageName);

        isSuccesfull.fold((l) {
          if (l is ServerFailure) {
            print("l is ServerFailure");
            emit(SaveImageFailedState());
          } else if (l is CacheFailure) {
            print("l is CacheFailure");
            emit(SaveImageFailedState());
          }
        }, (r) {
          print("SaveImageLoadedState");
          emit(SaveImageLoadedState(imageResponse: r));
        });
      },
    );
  }
}
