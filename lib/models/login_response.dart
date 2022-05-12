class LoginResponse {
  final String token;
  final String type;
  final int code;
  final String message;
  LoginResponse(
      {this.token = "", this.type = "", this.code = 0, this.message = ""});

  factory LoginResponse.fromJson(dynamic json) {
    var _token = json['token'] ?? "";
    var _type = json['type'] ?? "";
    var _code = json['code'] ?? 300;
    var _message = json['message'] ?? "";
    return LoginResponse(
        token: _token, type: _type, code: _code, message: _message);
  }
}
