part of 'upload_image_bloc.dart';

abstract class UploadImageEvent extends Equatable {
  const UploadImageEvent();

  @override
  List<Object?> get props => [];
}

class SaveImageEvent extends UploadImageEvent {
  final String imageName;

  const SaveImageEvent({required this.imageName});
  @override
  List<Object?> get props => [imageName];
}
