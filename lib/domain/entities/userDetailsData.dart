
import 'package:equatable/equatable.dart';
import 'package:salesforce/data/models/userDetailModel.dart';
import 'package:salesforce/domain/entities/userDetail.dart';

class UserDetailsData extends Equatable {
  final String? roleName;
  final String? roleId;
  final String? phoneNumber;
  final String? id;
  final String? email;
  final bool? status;
  final UserDetailsModel? userDetail;

  const UserDetailsData(
      { this.email,
       this.id,
       this.phoneNumber,
       this.roleId,
       this.roleName,
       this.status,
       this.userDetail});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [roleName, roleId, phoneNumber, id, email, status, userDetail];
}
