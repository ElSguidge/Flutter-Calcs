import 'package:json_annotation/json_annotation.dart';

part 'project_user_perm.g.dart';

@JsonSerializable()
class UserPermissions {
  String? summaryPermissions;

  UserPermissions({this.summaryPermissions});

  factory UserPermissions.fromJson(Map<String, dynamic> json) =>
      _$UserPermissionsFromJson(json);

  Map<String, dynamic> toJson() => _$UserPermissionsToJson(this);
}
