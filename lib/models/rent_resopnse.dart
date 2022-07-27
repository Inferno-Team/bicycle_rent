
class RentResponse {
  final int code;
  final String message;

  RentResponse({
    this.code = -1,
    this.message = '',
  });
  factory RentResponse.fromJson(dynamic json) {
    return RentResponse(
      code: json['code'] ?? 303,
      message: json['message'] ?? '',
    );
  }
  factory RentResponse.empty() {
    return RentResponse();
  }
}
