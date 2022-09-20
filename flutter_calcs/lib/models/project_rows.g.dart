// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_rows.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rows _$RowsFromJson(Map<String, dynamic> json) => Rows(
      json['id'] as int?,
      (json['cells'] as List<dynamic>?)
          ?.map((e) => Cells.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['createdAt'] as String?,
      json['expanded'] as bool?,
      json['inCriticalPath'] as bool?,
      json['modifiedAt'] as String?,
      json['rowNumber'] as int?,
      json['siblingId'] as int?,
    );

Map<String, dynamic> _$RowsToJson(Rows instance) => <String, dynamic>{
      'id': instance.id,
      'rowNumber': instance.rowNumber,
      'expanded': instance.expanded,
      'createdAt': instance.createdAt,
      'modifiedAt': instance.modifiedAt,
      'cells': instance.cells?.map((e) => e.toJson()).toList(),
      'siblingId': instance.siblingId,
      'inCriticalPath': instance.inCriticalPath,
    };
