import 'package:equatable/equatable.dart';

class Entity extends Equatable {
  final String name;
  final String phone;
  final String email;

  const Entity({required this.name, required this.phone, required this.email})
      : super();
  @override
  List<Object?> get props => [name, phone, email];
}
