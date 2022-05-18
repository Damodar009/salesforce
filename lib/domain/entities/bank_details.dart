import 'package:equatable/equatable.dart';

class BankDetails extends Equatable {
  final String? bankName;
  final String? accountName;
  final String? branchName;
  final String? accountNumber;

  const BankDetails(
      {required this.bankName,
      required this.accountName,
      required this.accountNumber,
      required this.branchName});
  @override
  // TODO: implement props
  List<Object?> get props => [bankName, accountName, branchName, accountNumber];
}
