import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:mygju_course_selection_server/course_datasource.dart';
import 'package:mygju_course_selection_server/responses.dart';

Future<Response> onRequest(RequestContext context) async {
  // TODO: implement route handler
  if (context.request.method == HttpMethod.get)
    return fetchCourses(context);
  else if (context.request.method == HttpMethod.post)
    return fetchSpecificCourses(context);
  else {
    return Response.json(body: 'Default Response');
  }
}

Future<Response> fetchSpecificCourses(RequestContext context) async {
  final json = await context.request.json();

  final year = json['year'] as int;
  final semester = json['semester'] as String;

  final department = json['department'] as String?;
  final course_name = json['course_name'] as String?;
  final course_id = json['course_id'] as String?;
  final inst_f_name = json['inst_f_name'] as String?;
  final inst_l_name = json['inst_l_name'] as String?;
  final section_num = json['section_num'] as String?;
  final room_name = json['room_name'] as String?;

  try {
    final courses = await CourseDataSource().getCourseInfo(
      year: year,
      semester: semester,
      department: department,
      course_id: course_id,
      course_name: course_name,
      inst_f_name: inst_f_name,
      inst_l_name: inst_l_name,
      room_name: room_name,
      section_num: section_num,
    );
    return Response(body: jsonEncode(courses), statusCode: 200);
  } catch (error) {
    return Response(
        body: jsonEncode({'error': 'Failed to fetch course'}), statusCode: 400);
  }
}

Future<Response> fetchCourses(RequestContext context) async {
  try {
    final courses = await CourseDataSource().getCourses();
    return Response(body: jsonEncode(courses), statusCode: 200);
  } catch (error) {
    return Response(
      body: jsonEncode({'error': '$error'}),
      statusCode: 400,
    );
  }

  //------
  // var data = await context.read<CourseDataSource>().getCourses();
  // return successResponse(data.map((e) => e.toJson()).toList());
}
// import 'dart:convert';
// import 'package:server/course_datasource.dart';
// import 'package:shelf/shelf.dart';
// import 'package:shelf_router/shelf_router.dart';

// Handler courseSelectionHandler() {
//   final router = Router();

//   router.get('/courses', (Request request) async {
//     try {
//       final courses = await CourseDataSource().getCourses();
//       return Response.ok(jsonEncode(courses));
//     } catch (error) {
//       return Response.internalServerError(
//           body: jsonEncode({'error': 'Failed to fetch courses'}));
//     }
//   });

//   return router;
// }

