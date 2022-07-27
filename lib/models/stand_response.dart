class StandResponse {
  final int code;
  final List<Stand> stands;
  StandResponse({required this.code, required this.stands});
  factory StandResponse.fromJson(dynamic json) {
    int code = json['code'] ?? 0;
    List<Stand> list =
        (json['stands'] as List).map((e) => Stand.fromJson(e)).toList();
    return StandResponse(code: code, stands: list);
  }
}

class Stand {
  String name;
  String location;
  String lat, long;
  int bicycleCount;
  int id;
  Stand(
      {this.name = "Select a stand",
      this.location = "",
      this.lat = "",
      this.long = "",
      this.bicycleCount = 0,
      this.id = 0});
  factory Stand.fromJson(dynamic json) {
    int id = json["id"] ?? 0;
    String name = json['name'] ?? "";
    String location = json["location"] ?? "";
    final count = json["bicycle_count"] ?? 0;
    int bicycleCount = count is int ? count : int.parse(count);
    String lat = json["lat"] ?? "0.0";
    String long = json["long"] ?? "0.0";
    return Stand(
        name: name,
        location: location,
        lat: lat,
        long: long,
        bicycleCount: bicycleCount,
        id: id);
  }
}

class CreateStandResponse {
  final Stand stand;
  final int code;
  final String message;
  CreateStandResponse(
      {required this.stand, required this.code, required this.message});
  factory CreateStandResponse.fromJson(dynamic json) {
    Stand stand = Stand.fromJson(json["stand"]);
    return CreateStandResponse(
      stand: stand,
      code: json["code"] ?? 300,
      message: json["message"] ?? "",
    );
  }
}
