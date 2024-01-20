import 'package:dart_frog/dart_frog.dart';
import 'package:mygju_course_selection_server/course.dart';
import 'package:mygju_course_selection_server/course_datasource.dart';

Future<Response> onRequest(RequestContext context) async {
  // TODO: implement route handler
  if (context.request.method == HttpMethod.post) return insertCourse(context);
  if (context.request.method == HttpMethod.patch) return updateCourse(context);
  if (context.request.method == HttpMethod.delete)
    return deleteCourse(context);
  else {
    return Response.json(body: 'Default Response /admin');
  }
}

Future<Response> deleteCourse(RequestContext context) async {
  return Response.json(body: '/admin/delete');
}

Future<Response> updateCourse(RequestContext context) async {
  final res = await context.read<CourseDataSource>().dothis();
  return Response.json(body: res);
}

Future<Response> insertCourse(RequestContext context) async {
  final json = await context.request.json();
  final year = json['year'] as int;
  final semester = json['semester'] as String;
  final degree = json['degree'] as String;
  final faculty = json['faculty'] as String;
  final department = json['department'] as String;
  final course_name = json['course_name'] as String;
  final course_id = json['course_id'] as String;
  final inst_f_name = json['inst_f_name'] as String;
  final inst_l_name = json['inst_l_name'] as String;
  final section_num = json['section_num'] as String;
  final room_name = json['room_name'] as String;
  final day = json['day'] as String;
  final from_time = json['from_time'] as String;
  final to_time = json['to_time'] as String;
  final max_num = json['max_num'] as int;
  final curr_num = json['curr_num'] as int;
  final credit_hrs = json['credit_hrs'] as int;
  final financial_hrs = json['financial_hrs'] as int;
  final isblocked = json['isblocked'] as int;
  final course = Course(
      course_id: course_id,
      year: year,
      semester: semester,
      degree: degree,
      faculty: faculty,
      department: department,
      inst_f_name: inst_f_name,
      inst_l_name: inst_l_name,
      room_name: room_name,
      section_num: section_num,
      day: day,
      from_time: from_time,
      to_time: to_time,
      max_num: max_num,
      curr_num: curr_num,
      credit_hrs: credit_hrs,
      financial_hrs: financial_hrs,
      isblocked: isblocked,
      course_name: course_name);
  final result = await context.read<CourseDataSource>().insertCourse(course);
  return Response.json(body: result);
}
