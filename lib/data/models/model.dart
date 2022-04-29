import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/entity.dart';

part 'model.g.dart';

@JsonSerializable()
class Model extends Entity {
  const Model(
      {required String name, required String phone, required String email})
      : super(name: name, phone: phone, email: email);

  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModelToJson(this);
}

// class User {
//   final String name;
//   final String email;
//
//   User(this.name, this.email);
//
//   User.fromJson(Map<String, dynamic> json)
//       : name = json['name'],
//         email = json['email'];
//
//   Map<String, dynamic> toJson() => {
//     'name': name,
//     'email': email,
//   };
// }
