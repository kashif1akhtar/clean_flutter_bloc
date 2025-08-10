import 'package:clean_arch/core/database/database_helper.dart';

import '../models/course_model.dart';

abstract class CourseLocalDataSource {
  Future<List<CourseModel>> getCourses();
  Future<void> cacheCourse(CourseModel course);
}

class CourseLocalDataSourceImpl implements CourseLocalDataSource {
  final DatabaseHelper databaseHelper;

  CourseLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<List<CourseModel>> getCourses() async {
    final courseMaps = await databaseHelper.getCourses();
    return courseMaps.map((map) => CourseModel.fromJson(map)).toList();
  }

  @override
  Future<void> cacheCourse(CourseModel course) async {
    await databaseHelper.insertCourse(course.toJson());
  }
}