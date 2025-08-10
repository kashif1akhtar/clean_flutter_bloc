import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/core/usecase/usecase.dart';
import 'package:clean_arch/feature/courses/domain/repository/course_repository.dart';
import 'package:dartz/dartz.dart';
import '../entities/course.dart';


class GetCourses implements UseCase<List<Course>, NoParams> {
  final CourseRepository repository;

  GetCourses(this.repository);

  @override
  Future<Either<Failure, List<Course>>> call(NoParams params) async {
    print("We are here to get the course");
    return await repository.getCourses();
  }
}

class NoParams {}