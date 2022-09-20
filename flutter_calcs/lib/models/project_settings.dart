import 'package:json_annotation/json_annotation.dart';

part 'project_settings.g.dart';

@JsonSerializable()
class ProjectSettings {
  List<String>? workingDays;
  List<String>? nonWorkingDays;
  double? lengthOfDay;

  ProjectSettings({this.workingDays, this.nonWorkingDays, this.lengthOfDay});

  factory ProjectSettings.fromJson(Map<String, dynamic> json) =>
      _$ProjectSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectSettingsToJson(this);
}
