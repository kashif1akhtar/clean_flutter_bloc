import '../../domain/entities/course.dart';

abstract class CourseState {
  const CourseState();
}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseLoaded extends CourseState {
  final List<Course> courses;

  CourseLoaded(this.courses);
}

class CourseCreated extends CourseState {
  final Course course;

  CourseCreated(this.course);
}

class CourseError extends CourseState {
  final String message;

  CourseError(this.message);
}