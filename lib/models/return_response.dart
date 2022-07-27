import 'package:bicycle_rent/models/event_response.dart';

class ReturnResponse {
  final int code;
  final String msg;
  final UserHistory history;

  ReturnResponse({required this.code, this.msg = "", required this.history});
  factory ReturnResponse.fromJson(dynamic json) {
    return ReturnResponse(
        code: json['code'] ?? 300, msg: json['message'] ?? "",
        history: UserHistory.fromJson(json['data']));
  }
}
