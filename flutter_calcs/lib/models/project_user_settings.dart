import 'package:json_annotation/json_annotation.dart';

part 'project_user_settings.g.dart';

@JsonSerializable()
class UserSettings {
  bool? criticalPathEnabled;
  bool? displaySummaryTasks;

  UserSettings({this.criticalPathEnabled, this.displaySummaryTasks});

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$UserSettingsToJson(this);
}
