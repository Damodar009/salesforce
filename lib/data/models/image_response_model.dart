import 'package:json_annotation/json_annotation.dart';
import 'package:salesforce/domain/entities/image.dart';

part 'image_response_model.g.dart';

@JsonSerializable()

class ImageResponseModel extends ImageResponse {
  ImageResponseModel(
      {String? id,
      String? image,
      String? imageType,
      String? path,
      String? uniqueKey})
      : super(
            id: id,
            image: image,
            imageType: imageType,
            path: path,
            uniqueKey: uniqueKey);

  factory ImageResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageResponseModelToJson(this);
}
