// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Income _$IncomeFromJson(Map<String, dynamic> json) => Income(
      id: json['id'] as String?,
      description: json['description'] as String,
      total: (json['total'] as num).toDouble(),
      expirationDate: DateTime.parse(json['expiration_date'] as String),
      type: $enumDecode(_$TypeEnumMap, json['type']),
      category: $enumDecode(_$CategoryEnumMap, json['category']),
      person: Person.fromJson(json['person'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IncomeToJson(Income instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'total': instance.total,
      'expiration_date': instance.expirationDate.toIso8601String(),
      'type': _$TypeEnumMap[instance.type],
      'category': _$CategoryEnumMap[instance.category],
      'person': instance.person,
    };

const _$TypeEnumMap = {
  Type.essential: 'essential',
  Type.nonEssential: 'nonEssential',
};

const _$CategoryEnumMap = {
  Category.fixed: 'fixed',
  Category.variable: 'variable',
};
