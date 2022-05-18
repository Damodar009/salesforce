import 'package:equatable/equatable.dart';

import '../../data/models/userDetailModel.dart';

class SaveUserDetailsData extends Equatable {
  final String? id;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final String? roleId;
  final String? roleName;
  final UserDetailsModel? userDetail;
  SaveUserDetailsData(
      {this.id,
      this.email,
      this.phoneNumber,
      this.password,
      this.roleId,
      this.userDetail,
      this.roleName});

  @override
  List<Object?> get props =>
      [id, email, phoneNumber, password, roleId, userDetail];
}
