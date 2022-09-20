import 'package:json_annotation/json_annotation.dart';

part 'project_cells.g.dart';

@JsonSerializable()
class Cells {
  int? columnId;
  dynamic value;
  String? displayValue;

  Cells(this.columnId, this.displayValue);

  factory Cells.fromJson(Map<String, dynamic> json) => _$CellsFromJson(json);

  Map<String, dynamic> toJson() => _$CellsToJson(this);
}
