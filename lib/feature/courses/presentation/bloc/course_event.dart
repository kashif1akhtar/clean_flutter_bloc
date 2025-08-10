import 'package:equatable/equatable.dart';

abstract class CourseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCourses extends CourseEvent {}

class CreateCourseEvent extends CourseEvent {
  final String title;
  final String description;

  CreateCourseEvent(this.title, this.description);

  @override
  List<Object> get props => [title, description];
}