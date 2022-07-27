import 'package:bicycle_rent/models/event_response.dart';

class CheckIfRentResponse {
  final int code;
  final String message;
  final CurrentUser currentUser;

  factory CheckIfRentResponse.fromJson(dynamic json) {
    return CheckIfRentResponse(
      code: json['code'] ?? 300,
      message: json['message'] ?? 'Error On Converting',
      currentUser: CurrentUser.fromJson(json['data']),
    );
  }
  factory CheckIfRentResponse.empty() {
    return CheckIfRentResponse(
      code: 300,
      message: '',
      currentUser: CurrentUser.empty(),
    );
  }

  CheckIfRentResponse(
      {required this.code, required this.message, required this.currentUser});
}
