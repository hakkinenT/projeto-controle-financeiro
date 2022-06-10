// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expense _$ExpenseFromJson(Map<String, dynamic> json) => Expense(
      id: json['id'] as String?,
      description: json['description'] as String,
      value: (json['value'] as num).toDouble(),
      classification:
          $enumDecode(_$ClassificationEnumMap, json['classification']),
      type: $enumDecode(_$TypeEnumMap, json['type']),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
    );

Map<String, dynamic> _$ExpenseToJson(Expense instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'value': instance.value,
      'classification': _$ClassificationEnumMap[instance.classification],
      'type': _$TypeEnumMap[instance.type],
      'user': instance.user,
      'expirationDate': instance.expirationDate?.toIso8601String(),
    };

const _$ClassificationEnumMap = {
  Classification.essential: 'essential',
  Classification.nonEssential: 'nonEssential',
};

const _$TypeEnumMap = {
  Type.fixed: 'fixed',
  Type.nonFixed: 'nonFixed',
};
