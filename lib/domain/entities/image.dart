import 'package:equatable/equatable.dart';

class ImageResponse extends Equatable {
  final String? id;
  final String? image;
  final String? imageType;
  final String? path;
  final String? uniqueKey;

  ImageResponse(
      {this.id, this.image, this.imageType, this.path, this.uniqueKey});
  @override
  // TODO: implement props
  List<Object?> get props => [id, image, imageType, path, uniqueKey];
}
