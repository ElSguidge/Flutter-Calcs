import 'package:flutter_calcs/models/project_columns.dart';
import 'package:flutter_calcs/models/project_rows.dart';
import 'package:flutter_calcs/models/project_user_perm.dart';
import 'package:flutter_calcs/models/project_user_settings.dart';
import 'package:json_annotation/json_annotation.dart';

import 'project_settings.dart';

part 'project_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProjectModel {
  int? id;
  String? name;
  int? version;
  int? totalRowCount;
  String? accessLevel;
  List<String>? effectiveAttachmentOptions;
  bool? readOnly;
  bool? ganttEnabled;
  bool? dependenciesEnabled;
  bool? resourceManagementEnabled;
  String? resourceManagementType;
  bool? cellImageUploadEnabled;
  bool? favorite;
  UserSettings? userSettings;
  UserPermissions? userPermissions;
  ProjectSettings? projectSettings;
  bool? hasSummaryFields;
  String? permalink;
  String? createdAt;
  String? modifiedAt;
  bool? isMultiPicklistEnabled;
  List<Columns>? columns;
  List<Rows>? rows;

  ProjectModel(
      {this.id,
      this.name,
      this.version,
      this.totalRowCount,
      this.accessLevel,
      this.effectiveAttachmentOptions,
      this.readOnly,
      this.ganttEnabled,
      this.dependenciesEnabled,
      this.resourceManagementEnabled,
      this.resourceManagementType,
      this.cellImageUploadEnabled,
      this.favorite,
      this.userSettings,
      this.userPermissions,
      this.projectSettings,
      this.hasSummaryFields,
      this.permalink,
      this.createdAt,
      this.modifiedAt,
      this.isMultiPicklistEnabled,
      this.columns,
      this.rows});

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectModelToJson(this);
}
