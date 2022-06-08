// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expenses _$ExpensesFromJson(Map<String, dynamic> json) => Expenses(
      id: json['id'] as String?,
      description: json['description'] as String,
      value: (json['value'] as num).toDouble(),
      category: $enumDecode(_$CategoryEnumMap, json['category']),
      type: $enumDecode(_$TypeEnumMap, json['type']),
      person: Person.fromJson(json['person'] as Map<String, dynamic>),
      expirationDate: DateTime.parse(json['expiration_date'] as String),
    );

Map<String, dynamic> _$ExpensesToJson(Expenses instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'value': instance.value,
      'category': _$CategoryEnumMap[instance.category],
      'type': _$TypeEnumMap[instance.type],
      'person': instance.person,
      'expiration_date': instance.expirationDate.toIso8601String(),
    };

const _$CategoryEnumMap = {
  Category.essential: 'essential',
  Category.nonEssential: 'nonEssential',
};

const _$TypeEnumMap = {
  Type.fixed: 'fixed',
  Type.variable: 'variable',
};
