import 'package:clean_arch/core/theme/bloc/theme_bloc.dart';
import 'package:clean_arch/core/theme/bloc/theme_event.dart';
import 'package:clean_arch/core/theme/bloc/theme_state.dart';
import 'package:clean_arch/feature/courses/presentation/bloc/course_event.dart';
import 'package:clean_arch/feature/courses/presentation/bloc/course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/course_bloc.dart';

class CoursePage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Theme(
          data: themeState.themeData,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Dashboard - Courses'),
              actions: [
                IconButton(
                  icon: Icon(Icons.brightness_6),
                  onPressed: () => context.read<ThemeBloc>().add(ToggleTheme()),
                ),
              ],
            ),
            body: BlocConsumer<CourseBloc, CourseState>(
              listener: (context, state) {
                if (state is CourseCreated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Course created: ${state.course.title}')),
                  );
                  context.read<CourseBloc>().add(FetchCourses());
                } else if (state is CourseError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is CourseLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is CourseLoaded) {
                  return ListView.builder(
                    itemCount: state.courses.length,
                    itemBuilder: (context, index) {
                      final course = state.courses[index];
                      return ListTile(
                        title: Text(course.title),
                        subtitle: Text(course.description),
                      );
                    },
                  );
                }
                return Center(child: Text('No courses available'));
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showCreateCourseDialog(context),
              child: Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }

  void _showCreateCourseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create Course'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<CourseBloc>().add(
                CreateCourseEvent(
                  _titleController.text,
                  _descriptionController.text,
                ),
              );
              _titleController.clear();
              _descriptionController.clear();
              Navigator.pop(context);
            },
            child: Text('Create'),
          ),
        ],
      ),
    );
  }
}