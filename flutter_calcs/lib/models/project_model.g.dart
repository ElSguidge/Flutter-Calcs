// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) => ProjectModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      version: json['version'] as int?,
      totalRowCount: json['totalRowCount'] as int?,
      accessLevel: json['accessLevel'] as String?,
      effectiveAttachmentOptions:
          (json['effectiveAttachmentOptions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      readOnly: json['readOnly'] as bool?,
      ganttEnabled: json['ganttEnabled'] as bool?,
      dependenciesEnabled: json['dependenciesEnabled'] as bool?,
      resourceManagementEnabled: json['resourceManagementEnabled'] as bool?,
      resourceManagementType: json['resourceManagementType'] as String?,
      cellImageUploadEnabled: json['cellImageUploadEnabled'] as bool?,
      favorite: json['favorite'] as bool?,
      userSettings: json['userSettings'] == null
          ? null
          : UserSettings.fromJson(json['userSettings'] as Map<String, dynamic>),
      userPermissions: json['userPermissions'] == null
          ? null
          : UserPermissions.fromJson(
              json['userPermissions'] as Map<String, dynamic>),
      projectSettings: json['projectSettings'] == null
          ? null
          : ProjectSettings.fromJson(
              json['projectSettings'] as Map<String, dynamic>),
      hasSummaryFields: json['hasSummaryFields'] as bool?,
      permalink: json['permalink'] as String?,
      createdAt: json['createdAt'] as String?,
      modifiedAt: json['modifiedAt'] as String?,
      isMultiPicklistEnabled: json['isMultiPicklistEnabled'] as bool?,
      columns: (json['columns'] as List<dynamic>?)
          ?.map((e) => Columns.fromJson(e as Map<String, dynamic>))
          .toList(),
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => Rows.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProjectModelToJson(ProjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'version': instance.version,
      'totalRowCount': instance.totalRowCount,
      'accessLevel': instance.accessLevel,
      'effectiveAttachmentOptions': instance.effectiveAttachmentOptions,
      'readOnly': instance.readOnly,
      'ganttEnabled': instance.ganttEnabled,
      'dependenciesEnabled': instance.dependenciesEnabled,
      'resourceManagementEnabled': instance.resourceManagementEnabled,
      'resourceManagementType': instance.resourceManagementType,
      'cellImageUploadEnabled': instance.cellImageUploadEnabled,
      'favorite': instance.favorite,
      'userSettings': instance.userSettings?.toJson(),
      'userPermissions': instance.userPermissions?.toJson(),
      'projectSettings': instance.projectSettings?.toJson(),
      'hasSummaryFields': instance.hasSummaryFields,
      'permalink': instance.permalink,
      'createdAt': instance.createdAt,
      'modifiedAt': instance.modifiedAt,
      'isMultiPicklistEnabled': instance.isMultiPicklistEnabled,
      'columns': instance.columns?.map((e) => e.toJson()).toList(),
      'rows': instance.rows?.map((e) => e.toJson()).toList(),
    };
