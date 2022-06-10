import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../models.dart';
part 'income.g.dart';

@JsonSerializable()
class Income extends Equatable {
  final String? id;
  final String description;
  final double value;
  final Type type;
  final User user;

  const Income(
      {this.id,
      required this.description,
      required this.value,
      required this.type,
      required this.user});

  factory Income.fromJson(Map<String, dynamic> json) => _$IncomeFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeToJson(this);

  Income copyWith(
      {String? id,
      String? description,
      double? value,
      Type? type,
      User? user}) {
    return Income(
        id: id ?? this.id,
        description: description ?? this.description,
        value: value ?? this.value,
        type: type ?? this.type,
        user: user ?? this.user);
  }

  @override
  List<Object?> get props => [id, description, type];
}