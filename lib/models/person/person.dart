import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable()
class Person extends Equatable {
  final String? id;
  final String email;
  final String name;
  final String userId;

  const Person(
      {this.id, required this.email, required this.name, required this.userId});

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  Person copyWith({String? id, String? email, String? name, String? userId}) {
    return Person(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        userId: userId ?? this.userId);
  }

  @override
  List<Object?> get props => [id, email, name];
}
