import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/domain/repositories/repository.dart';
import 'package:salesforce/error/failure.dart';
import 'package:salesforce/injectable.dart';

import '../datasource/remoteSource/upload_image_remote_data_source.dart';

@Injectable(as: UploadImageRepository)
class UploadImageRepositoryImpl implements UploadImageRepository {
  var uploadImageRemoteDataSource =
      getIt<UploadImageRemoteDataSource>();
  @override
  Future<Either<Failure, String>> uploadImageSave(String imageName) async {
    try {
      final response = await uploadImageRemoteDataSource.uploadImageSave(imageName);

      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
