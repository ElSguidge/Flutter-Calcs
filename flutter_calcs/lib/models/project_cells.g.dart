// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_cells.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cells _$CellsFromJson(Map<String, dynamic> json) => Cells(
      json['columnId'] as int?,
      json['displayValue'] as String?,
    )..value = json['value'];

Map<String, dynamic> _$CellsToJson(Cells instance) => <String, dynamic>{
      'columnId': instance.columnId,
      'value': instance.value,
      'displayValue': instance.displayValue,
    };
