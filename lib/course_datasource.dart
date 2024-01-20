import 'package:mysql1/mysql1.dart';

import 'package:mygju_course_selection_server/course.dart';

final settings = ConnectionSettings(
  host: 'localhost',
  port: 3307,
  user: 'root',
  password: 'password',
  db: 'test',
);

class CourseDataSource {
  CourseDataSource._internal() {
    //dotenv.load();
    _connect();
  }
  static final CourseDataSource _instance = CourseDataSource._internal();
  late MySqlConnection _connection;

  factory CourseDataSource() => _instance;

  Future<void> _connect() async {
    final settings = ConnectionSettings(
      host: 'localhost',
      port: 3307,
      user: 'root',
      password: 'password',
      db: 'test',
    );
    _connection = await MySqlConnection.connect(settings);
    await _connection.close();
  }

  Future<List<Course>> getCourses() async {
    final conn = await MySqlConnection.connect(settings);

    // Execute your query or operation
    final result = await _connection.query('SELECT * FROM courses');
    await conn.close();

    if (result.isEmpty) return Future.error('NotFound');
    print('@@@@${result.toString()}');

    final list = <Course>[];
    for (final row in result) {
      list.add(Course.fromJson(row.fields));
    }
    return list;
  }

  Future<String> dothis() async {
    final Results = await _connection.query('select now()');
    print(Results.toString());
    return Results.toString();
  }

  Future<Course> insertCourse(Course course) async {
    await _connection.query(
        'insert into courses (year, semester, degree, faculty, department, course_name, course_id, inst_f_name, inst_l_name,section_num, room_name, day, from_time, to_time, max_num, credit_hrs, financial_hrs, isblocked)values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? )',
        [
          course.year,
          course.semester,
          course.degree,
          course.faculty,
          course.department,
          course.course_name,
          course.course_id,
          course.inst_f_name,
          course.inst_l_name,
          course.section_num,
          course.room_name,
          course.day,
          course.from_time,
          course.to_time,
          course.max_num,
          course.credit_hrs,
          course.financial_hrs,
          course.isblocked,
        ]);
    return course;
  }

  Future<List<Course>> getCourseInfo({
    required int year,
    required String semester,
    String? course_id,
    String? department,
    String? inst_f_name,
    String? inst_l_name,
    String? room_name,
    String? section_num,
    String? course_name,
  }) async {
    //TODO: Seperate the Parameters into multiple Chunks, and insert them on their nullability.
    final result = await _connection.query(
        'SELECT * FROM courses where course_id = ? AND year = ? and semester = ? and  department = ?',
        [
          course_id ?? '',
          year,
          semester,
          department ?? '',
        ]);
    if (result.isEmpty) return Future.error('NotFound');

    final course = <Course>[];
    for (final row in result) {
      course.add(Course.fromJson(row.fields));
    }
    return course;
  }
}
