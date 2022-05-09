import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  final String fullName;
  final String gender;
  final String dob;
  final String permanentAddress;
  final String temporaryAddress;

  final String contactNumber2;

  const UserDetails(
      {required this.fullName,
      required this.gender,
      required this.dob,
      required this.permanentAddress,
      required this.temporaryAddress,
      required this.contactNumber2});

  @override
  List<Object?> get props => [
        fullName,
        gender,
        permanentAddress,
        dob,
        temporaryAddress,
        contactNumber2
      ];
}
