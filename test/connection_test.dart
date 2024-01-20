import 'package:mysql1/mysql1.dart';

void main() {
  Future<void> _connect() async {
    final settings = ConnectionSettings(
      host: 'localhost',
      port: 3307,
      user: 'root',
      password: 'password',
      db: 'test',
    );
    final _connection = await MySqlConnection.connect(settings);

    var res = await _connection.query('select now()').toString();

    print(res);
  }
}
