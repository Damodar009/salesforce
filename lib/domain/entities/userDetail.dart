import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  final String full_name;
  final String gender;
  final String path;
  final String permanent_address;
  final String temporary_address;
  final String user_detail_id;
  final String contact_number2;

  const UserDetails(
      {required this.full_name,
      required this.gender,
      required this.path,
      required this.permanent_address,
      required this.temporary_address,
      required this.user_detail_id,
      required this.contact_number2});

  @override
  // TODO: implement props
  List<Object> get props => [
        full_name,
        gender,
        path,
        permanent_address,
        temporary_address,
        user_detail_id,
        contact_number2
      ];
}
