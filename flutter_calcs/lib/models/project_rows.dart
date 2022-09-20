import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_calcs/models/project_cells.dart';

part 'project_rows.g.dart';

@JsonSerializable(explicitToJson: true)
class Rows {
  int? id;
  int? rowNumber;
  bool? expanded;
  String? createdAt;
  String? modifiedAt;
  List<Cells>? cells;
  int? siblingId;
  bool? inCriticalPath;

  Rows(this.id, this.cells, this.createdAt, this.expanded, this.inCriticalPath,
      this.modifiedAt, this.rowNumber, this.siblingId);

  factory Rows.fromJson(Map<String, dynamic> json) => _$RowsFromJson(json);

  Map<String, dynamic> toJson() => _$RowsToJson(this);
}
