class DeleteResponse {
  final String msg;
  final int code;
  DeleteResponse({required this.msg, required this.code});
  factory DeleteResponse.fromJson(dynamic json) {
    var msg = json['message'] ?? "";
    var code = json['code'] ?? 300;
    return DeleteResponse(msg: msg, code: code);
  }
  factory DeleteResponse.empty() {
    return DeleteResponse(msg: "", code: 300);
  }
}
