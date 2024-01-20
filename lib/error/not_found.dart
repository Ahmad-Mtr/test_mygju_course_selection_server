import 'package:mygju_course_selection_server/error/server_exception.dart';

class NotFoundException extends ServerException {
  NotFoundException(super.message, super.code);
}

class DataBaseException extends ServerException {
  DataBaseException(super.message, super.code);
}
