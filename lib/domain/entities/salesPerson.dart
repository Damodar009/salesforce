import 'package:equatable/equatable.dart';
import 'package:salesforce/data/models/userDetailModel.dart';
class SalesPerson extends Equatable {
  final String id;
  final String email;
  final String phoneNumber;
  final String password;
  final String roleId;
  final UserDetailsModel userDetails;
  SalesPerson(
      {required this.id,
      required this.email,
      required this.phoneNumber,
      required this.password,
      required this.roleId,
      required this.userDetails});

  @override
  List<Object?> get props =>
      [id, email, phoneNumber, password, roleId, userDetails];
}
