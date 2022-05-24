part of 'upload_image_bloc.dart';

abstract class UploadImageState extends Equatable {
  const UploadImageState();
  
  @override
  List<Object?> get props => [];
}

class UploadImageInitial extends UploadImageState {}

class SaveImageLoadingState extends UploadImageState{
  @override
  List<Object> get props => [];
}

class SaveImageLoadedState extends UploadImageState{
  final String? imageResponse;

  const SaveImageLoadedState({required this.imageResponse});
  @override
  List<Object?> get props => [imageResponse];
}

class SaveImageFailedState extends UploadImageState{
  @override
  List<Object> get props => [];
}
