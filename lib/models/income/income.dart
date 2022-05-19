import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../models.dart';
part 'income.g.dart';

@JsonSerializable()
class Income extends Equatable {
  final String? id;
  final String description;
  final double total;
  @JsonKey(name: 'expiration_date')
  final DateTime expirationDate;
  final Type type;
  final Category category;
  final Person person;

  const Income(
      {this.id,
      required this.description,
      required this.total,
      required this.expirationDate,
      required this.type,
      required this.category,
      required this.person});

  factory Income.fromJson(Map<String, dynamic> json) => _$IncomeFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeToJson(this);

  Income copyWith(
      {String? id,
      String? description,
      double? total,
      DateTime? expirationDate,
      Type? type,
      Category? category,
      Person? person}) {
    return Income(
        id: id ?? this.id,
        description: description ?? this.description,
        total: total ?? this.total,
        expirationDate: expirationDate ?? this.expirationDate,
        type: type ?? this.type,
        category: category ?? this.category,
        person: person ?? this.person);
  }

  @override
  List<Object?> get props => [id, description, total, expirationDate];
}
