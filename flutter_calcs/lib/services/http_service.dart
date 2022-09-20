import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_calcs/models/project_model.dart';

Future<ProjectModel> fetchProjects() async {
  String ssApi = dotenv.get("SS_ACCESS_TOKEN");
  final response = await http.get(
    Uri.parse('https://api.smartsheet.com/2.0/sheets/5728097002645380'),
    // Send authorization headers to the backend.
    headers: {HttpHeaders.authorizationHeader: ssApi},
  );
  // print(response.body);
  if (response.statusCode == 200) {
    print("Fetching data from api: ");
    // final responseJson = json.decode(response.body);
    // print(responseJson.length);
    final Map<String, dynamic> projectMap = json.decode(response.body);
    var object = ProjectModel.fromJson(projectMap);
    // print(responseJson);
    return object;
  } else {
    throw Exception('Failed to load data!');
  }
}
