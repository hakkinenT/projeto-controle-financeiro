import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'expense.g.dart';

@JsonSerializable()
class Expense extends Equatable {
  final String? id;
  final String description;
  final double value;
  final Classification classification;
  final Type type;
  final User user;

  final DateTime? expirationDate;

  const Expense({
    this.id,
    required this.description,
    required this.value,
    required this.classification,
    required this.type,
    required this.user,
    this.expirationDate,
  });

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseToJson(this);

  Expense copyWith({
    String? id,
    String? description,
    double? value,
    Classification? classification,
    Type? type,
    User? user,
    DateTime? expirationDate,
  }) {
    return Expense(
      id: id ?? this.id,
      description: description ?? this.description,
      value: value ?? this.value,
      classification: classification ?? this.classification,
      type: type ?? this.type,
      user: user ?? this.user,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }

  @override
  List<Object?> get props => [id, description, value, classification, user];
}
