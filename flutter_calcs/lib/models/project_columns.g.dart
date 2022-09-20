// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_columns.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Columns _$ColumnsFromJson(Map<String, dynamic> json) => Columns(
      id: json['id'] as int?,
      version: json['version'] as int?,
      index: json['index'] as int?,
      title: json['title'] as String?,
      type: json['type'] as String?,
      validation: json['validation'] as bool?,
      width: json['width'] as int?,
      primary: json['primary'] as bool?,
      options:
          (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
      contactOptions: (json['contactOptions'] as List<dynamic>?)
          ?.map((e) => ContactOptions.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ColumnsToJson(Columns instance) => <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'index': instance.index,
      'title': instance.title,
      'type': instance.type,
      'validation': instance.validation,
      'width': instance.width,
      'primary': instance.primary,
      'options': instance.options,
      'contactOptions':
          instance.contactOptions?.map((e) => e.toJson()).toList(),
      'tags': instance.tags,
    };
