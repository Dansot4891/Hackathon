import 'package:freezed_annotation/freezed_annotation.dart';

class User {
  late int id;
  late String email, name, pw, emoji;

  User(
    this.id,
    this.email,
    this.name,
    this.pw,
    this.emoji
    );

  User.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    pw = json['pw'];
    emoji = json['emoji'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'pw': pw,
        'emoji' : emoji
  };
}

// part 'user.freezed.dart';
// part 'user.g.dart';

// @freezed
// class User with _$User {

//   factory User(String email, String name, String pw, String emoji) = _User;

//   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  
// }