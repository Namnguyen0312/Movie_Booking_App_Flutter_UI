class AuthResponseModel {
  final int statusCode;
  final String message;
  final String accessToken;
  final int logInTime;
  final int expirationDuration;

  AuthResponseModel({
    required this.statusCode,
    required this.message,
    required this.accessToken,
    required this.logInTime,
    required this.expirationDuration,
  });
}
