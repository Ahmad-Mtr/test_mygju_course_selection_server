class Course {
  final String course_id;
  final int year;
  final String semester;
  final String degree;
  final String faculty;
  final String department;
  final String course_name;
  final String inst_f_name;
  final String inst_l_name;
  final String room_name;
  final String section_num;
  final String day;
  final String from_time;
  final String to_time;
  final int max_num;
  final int curr_num;
  final int credit_hrs;
  final int financial_hrs;
  final int isblocked;

  Course({
    required this.course_id,
    required this.year,
    required this.semester,
    required this.degree,
    required this.faculty,
    required this.department,
    required this.inst_f_name,
    required this.inst_l_name,
    required this.room_name,
    required this.section_num,
    required this.day,
    required this.from_time,
    required this.to_time,
    required this.max_num,
    this.curr_num = 0,
    required this.credit_hrs,
    required this.financial_hrs,
    required this.isblocked,
    required this.course_name,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      course_id: json['course_id'].toString(),
      year: json['year'] as int,
      semester: json['semester'].toString(),
      degree: json['degree'].toString(),
      faculty: json['faculty'].toString(),
      department: json['department'].toString(),
      course_name: json['course_name'].toString(),
      inst_f_name: json['inst_f_name'].toString(),
      inst_l_name: json['inst_l_name'].toString(),
      room_name: json['room_name'].toString(),
      section_num: json['section_num'].toString(),
      day: json['day'].toString(),
      from_time: json['from_time'].toString(),
      to_time: json['to_time'].toString(),
      max_num: json['max_num'] as int,
      curr_num: json['curr_num'] as int,
      credit_hrs: json['credit_hrs'] as int,
      financial_hrs: json['financial_hrs'] as int,
      isblocked: json['isblocked'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'course_id': course_id,
        'year': year,
        'semester': semester,
        'degree': degree,
        'faculty': faculty,
        'department': department,
        'course_name': course_name,
        'inst_f_name': inst_f_name,
        'inst_l_name': inst_l_name,
        'room_name': room_name,
        'section_num': section_num,
        'day': day,
        'from_time': from_time,
        'to_time': to_time,
        'max_num': max_num,
        'curr_num': curr_num,
        'credit_hrs': credit_hrs,
        'financial_hrs': financial_hrs,
        'isblocked': isblocked,
      };
}
