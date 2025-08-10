import '../../domain/entities/course.dart';

class CourseModel extends Course {
  CourseModel({
    required String courseId,
    required String courseName,
    required String description,
    required String courseType,
    required String availableCountry,
    required int noOfClasses,
    required int discount,
    required String totalCourseTime,
    required String sessionTiming,
    required String requirements,
    required String intendedFor,
    required String whatYouWillLearn,
    required String courseContent,
    required String ratings,
    required String? courseImage,
    required String createdDate,
    required String createdBy,
    required String modifiedDate,
    required String modifiedBy,
    required String? courseScheduleType,
    required String bizType,
    required int price,
    required String currency,
  }) : super( title: courseName, description: description, id: courseId);

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      courseId: json['course_id'] ?? '',
      courseName: json['course_name'] ?? '',
      description: json['description'] ?? '',
      courseType: json['course_type'] ?? '',
      availableCountry: json['available_country'] ?? '',
      noOfClasses: json['no_of_classes'] ?? 0,
      discount: json['discount'] ?? 0,
      totalCourseTime: json['total_course_time'] ?? '',
      sessionTiming: json['session_timing'] ?? '',
      requirements: json['requirements'] ?? '',
      intendedFor: json['intended_for'] ?? '',
      whatYouWillLearn: json['what_you_will_learn'] ?? '',
      courseContent: json['course_content'] ?? '',
      ratings: json['ratings'] ?? '',
      courseImage: json['course_image'],
      createdDate: json['created_date'] ?? '',
      createdBy: json['created_by'] ?? '',
      modifiedDate: json['modified_date'] ?? '',
      modifiedBy: json['modified_by'] ?? '',
      courseScheduleType: json['course_schedule_type'],
      bizType: json['biz_type'] ?? '',
      price: json['price'] ?? 0,
      currency: json['currency'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course_id': id,
      'course_name': title,
      'description': description,
    };
  }
}
