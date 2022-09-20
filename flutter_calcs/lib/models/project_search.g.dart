// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectSearch _$ProjectSearchFromJson(Map<String, dynamic> json) =>
    ProjectSearch(
      address: json['address'] as String,
      budget: json['budget'] as String,
      jobNumber: json['jobNumber'] as String,
      major: json['major'] as String,
      name: json['name'] as String,
      pM: json['pM'] as String,
      tech: json['tech'] as String,
    );

Map<String, dynamic> _$ProjectSearchToJson(ProjectSearch instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'jobNumber': instance.jobNumber,
      'tech': instance.tech,
      'major': instance.major,
      'pM': instance.pM,
      'budget': instance.budget,
    };
