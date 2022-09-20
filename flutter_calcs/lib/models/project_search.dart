import 'package:json_annotation/json_annotation.dart';

part 'project_search.g.dart';

@JsonSerializable()
class ProjectSearch {
  final String name;
  final String address;
  final String jobNumber;
  final String tech;
  final String major;
  final String pM;
  final String budget;

  const ProjectSearch(
      {required this.address,
      required this.budget,
      required this.jobNumber,
      required this.major,
      required this.name,
      required this.pM,
      required this.tech});

  @override
  String toString() {
    return '{address: $address, name: $name, jobNumber: $jobNumber, pm: $pM, tech: $tech, major: $major, budget: $budget}';
  }

  factory ProjectSearch.fromJson(Map<String, dynamic> json) =>
      _$ProjectSearchFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectSearchToJson(this);
}
