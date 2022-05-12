class MessageResponse {
  final int code;
  final String message;
  MessageResponse({this.code = 0, this.message = ""});

  factory MessageResponse.fromJson(dynamic json) {
    var _code = json['code'] ?? 300;
    var _message = json['message'] ?? "";
    return MessageResponse(code: _code, message: _message);
  }
}
