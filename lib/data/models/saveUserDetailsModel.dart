import 'package:salesforce/domain/entities/saveUserDetails.dart';

class SaveUserDetailsModel extends SaveUserDetails {
  SaveUserDetailsModel(
      {required String fullName,
      required String gender,
      required String dob,
      required String permanentAddress,
      required String temporaryAddress,
      required String userDocument,
      required String contactNumber2})
      : super(
            fullName: fullName,
            gender: gender,
            dob: dob,
            permanentAddress: permanentAddress,
            temporaryAddress: temporaryAddress,
            userDocument: userDocument,
            contactNumber2: contactNumber2);
}
