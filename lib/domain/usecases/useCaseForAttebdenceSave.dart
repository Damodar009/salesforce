import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salesforce/domain/entities/attendence.dart';

import '../../error/failure.dart';
import '../../injectable.dart';
import '../entities/AttendendenceDashbard.dart';
import '../repositories/repository.dart';

abstract class UseCaseForAttendence {
  Future<Either<Failure, Attendence?>> attendenceSave(Attendence attendence);
  Future<Either<Failure, AttendanceDashboard?>> getDashBoardAttendance();
}

@injectable
class UseCaseForAttendenceImpl implements UseCaseForAttendence {
  var attendenceRepository = getIt<AttendenceRepository>();
  UseCaseForAttendenceImpl({required this.attendenceRepository});

  @override
  Future<Either<Failure, Attendence?>> attendenceSave(
      Attendence attendence) async {
    print("use case for attendence repository");
    return await attendenceRepository.saveAttendence(attendence);
  }

  @override
  Future<Either<Failure, AttendanceDashboard?>> getDashBoardAttendance() async {
    return await attendenceRepository.getDashBoardAttendance();
  }
}
