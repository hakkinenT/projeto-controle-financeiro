// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Income _$IncomeFromJson(Map<String, dynamic> json) => Income(
      id: json['id'] as String?,
      description: json['description'] as String,
      value: (json['value'] as num).toDouble(),
      type: $enumDecode(_$TypeEnumMap, json['type']),
      person: Person.fromJson(json['person'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IncomeToJson(Income instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'value': instance.value,
      'type': _$TypeEnumMap[instance.type],
      'person': instance.person,
    };

const _$TypeEnumMap = {
  Type.fixed: 'fixed',
  Type.variable: 'variable',
};
