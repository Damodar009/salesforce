import 'package:equatable/equatable.dart';

class SaveUserDetails extends Equatable {
  final String fullName;
  final String gender;
  final String dob;
  final String permanentAddress;
  final String temporaryAddress;
  final String userDocument;
  final String contactNumber2;

  const SaveUserDetails(
      {required this.fullName,
      required this.gender,
      required this.dob,
      required this.permanentAddress,
      required this.temporaryAddress,
      required this.userDocument,
      required this.contactNumber2});

  @override
  List<Object> get props => [
        fullName,
        gender,
        dob,
        permanentAddress,
        temporaryAddress,
        userDocument,
        contactNumber2
      ];
}
