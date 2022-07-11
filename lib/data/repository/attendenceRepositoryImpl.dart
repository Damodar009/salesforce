import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/domain/entities/AttendendenceDashbard.dart';
import 'package:salesforce/domain/entities/attendence.dart';
import 'package:salesforce/error/failure.dart';
import '../../domain/repositories/repository.dart';
import '../../injectable.dart';
import '../datasource/remoteSource/attendenceSave.dart';

@Injectable(as: AttendenceRepository)
class AttendenceRepositoryImpl implements AttendenceRepository {
  var attendenceRemoteSource = getIt<AttendenceRemoteSource>();
  AttendenceRepositoryImpl({required this.attendenceRemoteSource});

  @override
  Future<Either<Failure, Attendence>> saveAttendence(
      Attendence attendance) async {
    try {
      final question = await attendenceRemoteSource.saveAttendence(attendance);
      return Right(question);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AttendanceDashboard?>> getDashBoardAttendance() async {
    try {
      final question = await attendenceRemoteSource.getDashBoardAttendance();
      return Right(question);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
