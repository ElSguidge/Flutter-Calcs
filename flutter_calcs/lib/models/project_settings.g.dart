// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectSettings _$ProjectSettingsFromJson(Map<String, dynamic> json) =>
    ProjectSettings(
      workingDays: (json['workingDays'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      nonWorkingDays: (json['nonWorkingDays'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lengthOfDay: (json['lengthOfDay'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProjectSettingsToJson(ProjectSettings instance) =>
    <String, dynamic>{
      'workingDays': instance.workingDays,
      'nonWorkingDays': instance.nonWorkingDays,
      'lengthOfDay': instance.lengthOfDay,
    };
