import '../utils/constants.dart';

class ResponseModel {
  final ResponseStatus responseStatus;
  final int statusCode;
  final String message;
  final Map<String, dynamic> object;

  ResponseModel({
    required this.responseStatus,
    required this.statusCode,
    required this.message,
    required this.object,
  });
}
