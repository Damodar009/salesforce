import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  final String? designationId;
  final String? id;
  final String? fullName;
  final String? gender;
  final String? dob;
  final String? path;
  final String? permanentAddress;
  final String? temporaryAddress;
  final String? userDocument;
  final String? user_detail_id;
  final String? contactNumber2;
  final String? employee_contract;

  const UserDetails(
      {this.fullName,
      this.id,
      this.dob,
      this.path,
      this.userDocument,
      this.user_detail_id,
      this.gender,
      this.permanentAddress,
      this.temporaryAddress,
      this.contactNumber2,
      this.designationId,
      this.employee_contract});

  @override
  // TODO: implement props
  List<Object?> get props => [
        fullName,
        id,
        dob,
        path,
        userDocument,
        user_detail_id,
        gender,
        permanentAddress,
        temporaryAddress,
        contactNumber2,
        designationId,
        employee_contract
      ];
}
