import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/data/models/image_response_model.dart';
import 'package:salesforce/domain/entities/image.dart';

import 'package:salesforce/domain/repositories/repository.dart';
import 'package:salesforce/error/failure.dart';
import 'package:salesforce/injectable.dart';

abstract class UseCaseForUploadImage {
  Future<Either<Failure, String>> uploadImageSave(String imageName);
}

@injectable
class UseCaseForUploadImageImpl implements UseCaseForUploadImage {
  var uploadImageRepository = getIt<UploadImageRepository>();
  UseCaseForUploadImageImpl();

  @override
  Future<Either<Failure, String>> uploadImageSave(String imageName) async {
    return await uploadImageRepository.uploadImageSave(imageName);
  }
}
