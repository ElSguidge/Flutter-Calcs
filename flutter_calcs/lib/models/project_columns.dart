import 'package:json_annotation/json_annotation.dart';

import 'project_contact_options.dart';

part 'project_columns.g.dart';

@JsonSerializable(explicitToJson: true)
class Columns {
  int? id;
  int? version;
  int? index;
  String? title;
  String? type;
  bool? validation;
  int? width;
  bool? primary;
  List<String>? options;
  List<ContactOptions>? contactOptions;
  List<String>? tags;

  Columns(
      {this.id,
      this.version,
      this.index,
      this.title,
      this.type,
      this.validation,
      this.width,
      this.primary,
      this.options,
      this.contactOptions,
      this.tags});
  factory Columns.fromJson(Map<String, dynamic> json) =>
      _$ColumnsFromJson(json);

  Map<String, dynamic> toJson() => _$ColumnsToJson(this);
}
