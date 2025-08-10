import 'dart:convert';
import 'package:clean_arch/core/constants/constants.dart';
import 'package:clean_arch/core/error/exceptions.dart';
import 'package:clean_arch/core/error/failures.dart';
import 'package:http/http.dart' as http;
import '../models/course_model.dart';

abstract class CourseRemoteDataSource {
  Future<List<CourseModel>> getCourses();
  Future<CourseModel> createCourse(String title, String description);
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  final http.Client client;


  CourseRemoteDataSourceImpl(this.client);

  @override
  Future<List<CourseModel>> getCourses() async {
    final response = await client.get(
      Uri.parse(Constants.baseUrl+'/api/v1/course?biz_type=BB&request_country=India'),
      headers: {'Content-Type': 'application/json'},
    );

    print("Whats the response"+response.body.toString()+ response.statusCode.toString());

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => CourseModel.fromJson(json)).toList();
    } else {
      throw Failure('Failed to fetch courses');
    }
  }

  @override
  Future<CourseModel> createCourse(String title, String description) async {
    final response = await client.post(
      Uri.parse('https://your-api.com/courses'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'description': description}),
    );

    if (response.statusCode == 201) {
      return CourseModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException('Failed to create course');
    }
  }
}