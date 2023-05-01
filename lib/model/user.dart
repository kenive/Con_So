import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class Users {
  String email;

  String name;

  String ngayTao;

  int score;

  // String timeEnd;

  String uid;

  Users(
      {required this.email,
      required this.name,
      required this.ngayTao,
      required this.score,
      // required this.timeEnd,
      required this.uid});

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);

  static get userEmpty {
    return Users(email: '', name: '', ngayTao: '', score: 0, uid: '');
  }
}
