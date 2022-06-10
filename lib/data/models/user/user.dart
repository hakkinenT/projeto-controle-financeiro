import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.id,
      this.email,
      this.name,
      this.photo,
      this.emailVerified});

  final String? email;
  final String? name;
  final String id;
  final String? photo;
  final bool? emailVerified;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, id, name, photo, emailVerified];

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String?,
        email = json['email'] as String?,
        photo = json['photo'] as String?,
        emailVerified = json['emailVerified'] as bool?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'photo': photo,
        'emailVerified': emailVerified
      };

  User copyWith(
      {String? id,
      String? name,
      String? email,
      String? photo,
      bool? emailVerified}) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        photo: photo ?? this.photo,
        emailVerified: emailVerified ?? this.emailVerified);
  }
}
