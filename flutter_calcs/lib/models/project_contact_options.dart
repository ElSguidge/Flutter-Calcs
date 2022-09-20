import 'package:json_annotation/json_annotation.dart';

part 'project_contact_options.g.dart';

@JsonSerializable()
class ContactOptions {
  String? name;
  String? email;

  ContactOptions({this.name, this.email});
  factory ContactOptions.fromJson(Map<String, dynamic> json) =>
      _$ContactOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$ContactOptionsToJson(this);
}
