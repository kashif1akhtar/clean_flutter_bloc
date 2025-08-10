import 'package:clean_arch/feature/courses/domain/usecases/get_course.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_course.dart';
import 'course_event.dart';
import 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetCourses getCourses;
  final CreateCourse createCourse;

  CourseBloc(this.getCourses, this.createCourse) : super(CourseInitial()) {
    on<FetchCourses>((event, emit) async {
      emit(CourseLoading());
      final result = await getCourses(NoParams());
      result.fold(
            (failure) => emit(CourseError(failure.message)),
            (courses) => emit(CourseLoaded(courses)),
      );
    });

    on<CreateCourseEvent>((event, emit) async {
      emit(CourseLoading());
      final result = await createCourse(CreateCourseParams(
        title: event.title,
        description: event.description,
      ));
      result.fold(
            (failure) => emit(CourseError(failure.message)),
            (course) => emit(CourseCreated(course)),
      );
    });
  }
}