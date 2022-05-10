// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_expenses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthlyExpenses _$MonthlyExpensesFromJson(Map<String, dynamic> json) =>
    MonthlyExpenses(
      id: json['id'] as String?,
      description: json['description'] as String,
      total: (json['total'] as num).toDouble(),
      category: $enumDecode(_$CategoryEnumMap, json['category']),
      person: Person.fromJson(json['person'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MonthlyExpensesToJson(MonthlyExpenses instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'total': instance.total,
      'category': _$CategoryEnumMap[instance.category],
      'person': instance.person,
    };

const _$CategoryEnumMap = {
  Category.fixed: 'fixed',
  Category.variable: 'variable',
};
