abstract class ServerException implements Exception {
  const ServerException(this.message, this.code);

  final String message;
  final int code;

  Map<String, dynamic> get response => {
        'message': message,
      };
}
