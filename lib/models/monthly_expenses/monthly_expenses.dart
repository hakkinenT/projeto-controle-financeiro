import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../category/category.dart';
import '../models.dart';

part 'monthly_expenses.g.dart';

@JsonSerializable()
class MonthlyExpenses extends Equatable {
  final String? id;
  final String description;
  final double total;
  final Category category;
  final Person person;

  const MonthlyExpenses(
      {this.id,
      required this.description,
      required this.total,
      required this.category,
      required this.person});

  factory MonthlyExpenses.fromJson(Map<String, dynamic> json) =>
      _$MonthlyExpensesFromJson(json);

  Map<String, dynamic> toJson() => _$MonthlyExpensesToJson(this);

  MonthlyExpenses copyWith(
      {String? id,
      String? description,
      double? total,
      Category? category,
      Person? person}) {
    return MonthlyExpenses(
        id: id ?? this.id,
        description: description ?? this.description,
        total: total ?? this.total,
        category: category ?? this.category,
        person: person ?? this.person);
  }

  @override
  List<Object?> get props => [
        id,
        description,
        total,
        category,
      ];
}
