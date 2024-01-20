import 'package:dart_frog/dart_frog.dart';
import 'package:mygju_course_selection_server/course_datasource.dart';
import 'package:mygju_course_selection_server/error/not_found.dart';
import 'package:mygju_course_selection_server/responses.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(injectionHandler()).use((handler) {
    return (context) async {
      try {
        final response = await handler(context);
        return response;
      } catch (e) {
        if (e is NotFoundException) {
          return Response.json(body: e.response, statusCode: e.code);
        }
        if (e is DataBaseException) {
          return errorResponse(e.message);
        }
        return Response.json();
      }
    };
  });
}

Middleware injectionHandler() {
  return (handler) {
    return handler.use(
      provider<CourseDataSource>(
        (context) => CourseDataSource(),
      ),
    );
  };
}
// import 'package:shelf/shelf.dart';

// Middleware handleCors() {
//   return (Handler innerHandler) {
//     return (Request request) async {
//       if (request.method == 'OPTIONS') {
//         return Response.ok(null, headers: {
//           'Access-Control-Allow-Origin': '*',
//           'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
//           'Access-Control-Allow-Headers': 'Origin, Content-Type, Accept',
//         });
//       } else {
//         final response = await innerHandler(request);
//         response.headers['Access-Control-Allow-Origin'] = '*';
//         return response;
//       }
//     };
//   };
// }
