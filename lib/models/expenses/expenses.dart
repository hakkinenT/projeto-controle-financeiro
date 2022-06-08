import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'expenses.g.dart';

@JsonSerializable()
class Expenses extends Equatable {
  final String? id;
  final String description;
  final double value;
  final Category category;
  final Type type;
  final Person person;
  @JsonKey(name: 'expiration_date')
  final DateTime expirationDate;

  const Expenses({
    this.id,
    required this.description,
    required this.value,
    required this.category,
    required this.type,
    required this.person,
    required this.expirationDate,
  });

  factory Expenses.fromJson(Map<String, dynamic> json) =>
      _$ExpensesFromJson(json);

  Map<String, dynamic> toJson() => _$ExpensesToJson(this);

  Expenses copyWith({
    String? id,
    String? description,
    double? value,
    Category? category,
    Type? type,
    Person? person,
    DateTime? expirationDate,
  }) {
    return Expenses(
      id: id ?? this.id,
      description: description ?? this.description,
      value: value ?? this.value,
      category: category ?? this.category,
      type: type ?? this.type,
      person: person ?? this.person,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        description,
        value,
        category,
      ];
}
