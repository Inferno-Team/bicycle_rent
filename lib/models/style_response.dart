class BicycleStyle {
  String name;
  String color;
  String size;
  int id;
  BicycleStyle({
    this.name = "",
    this.color = "",
    this.size = "",
    this.id = 0,
  });

  factory BicycleStyle.fromJson(dynamic json) {
    var name = json['name'] ?? "";
    var color = json['color'] ?? '';
    var size = json['size'] ?? '';
    var id = json['id'] ?? 0;
    return BicycleStyle(size: size, color: color, name: name, id: id);
  }
  factory BicycleStyle.empty() {
    return BicycleStyle(size: '', color: '', name: 'select a style', id: -1);
  }

  void empty() {
    name = "";
    id = -1;
    size = "";
    color = "";
  }
}

class CreateStyleResponse {
  final int code;
  final String message;
  final BicycleStyle style;
  CreateStyleResponse({
    required this.code,
    required this.message,
    required this.style,
  });
  factory CreateStyleResponse.fromJson(dynamic json) {
    return CreateStyleResponse(
      code: json['code'] ?? 401,
      message: json['message'] ?? "",
      style: BicycleStyle.fromJson(json['style']),
    );
  }
}
