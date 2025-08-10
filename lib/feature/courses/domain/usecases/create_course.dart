import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/core/usecase/usecase.dart';
import 'package:clean_arch/feature/courses/domain/repository/course_repository.dart';
import 'package:dartz/dartz.dart';
import '../entities/course.dart';

class CreateCourse implements UseCase<Course, CreateCourseParams> {
  final CourseRepository repository;

  CreateCourse(this.repository);

  @override
  Future<Either<Failure, Course>> call(CreateCourseParams params) async {
    return await repository.createCourse(params.title, params.description);
  }
}

class CreateCourseParams {
  final String title;
  final String description;

  CreateCourseParams({required this.title, required this.description});
}