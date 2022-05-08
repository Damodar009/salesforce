
import 'package:equatable/equatable.dart';
import 'package:salesforce/data/models/userDetailModel.dart';
import 'package:salesforce/domain/entities/userDetail.dart';

class UserDetailsData extends Equatable {
  final String role_name;
  final String role_id;
  final String phone_number;
  final String id;
  final String email;
  final bool status;
  final UserDetailsModel userDetail;

  const UserDetailsData(
      {required this.email,
      required this.id,
      required this.phone_number,
      required this.role_id,
      required this.role_name,
      required this.status,
      required this.userDetail});

  @override
  // TODO: implement props
  List<Object> get props =>
      [role_name, role_id, phone_number, id, email, status, userDetail];
}
