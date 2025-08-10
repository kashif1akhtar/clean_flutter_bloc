import 'package:clean_arch/core/error/exceptions.dart';
import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/feature/courses/data/data_source/course_local_db.dart';
import 'package:clean_arch/feature/courses/data/data_source/remote_data_source.dart';
import 'package:clean_arch/feature/courses/domain/repository/course_repository.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/course.dart';
import '../models/course_model.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource remoteDataSource;
  final CourseLocalDataSource localDataSource;

  CourseRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, List<Course>>> getCourses() async {
    try {
      final remoteCourses = await remoteDataSource.getCourses();
      print("Api call happened here ----");
      for (var course in remoteCourses) {
        await localDataSource.cacheCourse(course);
    }
    return Right(remoteCourses);
    } catch (e) {
      try {
        final localCourses = await localDataSource.getCourses();
        return Right(localCourses);
      } catch (e) {
        return Left(Failure('Failed to fetch courses'));
      }
    }
  }

  @override
  Future<Either<Failure, Course>> createCourse(String title, String description) async {
    try {
      final course = await remoteDataSource.createCourse(title, description);
      await localDataSource.cacheCourse(course);
      return Right(course);
    } catch (e) {
      return Left(Failure('Failed to create course'));
    }
  }
}