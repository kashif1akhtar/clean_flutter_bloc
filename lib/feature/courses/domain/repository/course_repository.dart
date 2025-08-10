import 'package:clean_arch/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/course.dart';

abstract class CourseRepository {
  Future<Either<Failure, List<Course>>> getCourses();
  Future<Either<Failure, Course>> createCourse(String title, String description);
}