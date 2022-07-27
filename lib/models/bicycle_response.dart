import 'package:bicycle_rent/models/esp32user_response.dart';
import 'package:bicycle_rent/models/style_response.dart';

class Bicycle {
  final String name;
  final lat;
  final long;
  final pricePerTime;
  final pricePerDistance;
  final bool isAvailable;
  final BicycleStyle? style;
  final Esp32User? esp32;
  final String imgURL;
  final int id;
  Bicycle(
      {this.id = -1,
      this.name = "",
      this.lat,
      this.long,
      this.pricePerTime,
      this.pricePerDistance,
      this.isAvailable = false,
      this.style,
      this.esp32,
      this.imgURL = ""});
  factory Bicycle.fromJson(dynamic json) {
    var _name = json['name'] ?? "";
    var id = json['id'] ?? -1;
    var _lat = json['lat'] ?? 0.0;
    var _long = json['long'] ?? 0.0;
    var _pricePerTime = json['price_per_time'] ?? "";
    var _pricePerDestance = json['price_per_distance'] ?? "";
    var _isAvailable = json['is_available'] ?? false;
    var _style = BicycleStyle.fromJson(json['style']);
    var _esp32 = Esp32User.fromJson(json['esp32']);
    var imgURL = json['img_url'];
    return Bicycle(
      id: id,
      name: _name,
      lat: _lat,
      long: _long,
      pricePerDistance: _pricePerDestance,
      pricePerTime: _pricePerTime,
      isAvailable: _isAvailable,
      style: _style,
      esp32: _esp32,
      imgURL: imgURL,
    );
  }
  factory Bicycle.empty() {
    return Bicycle();
  }
}

class BicycleResponse {
  final int code;
  final List<Bicycle> bicycles;
  BicycleResponse({required this.code, required this.bicycles});

  factory BicycleResponse.fromJson(dynamic json) {
    var code = json['code'] ?? 300;
    var list =
        (json['bicycles'] as List).map((e) => Bicycle.fromJson(e)).toList();
    return BicycleResponse(code: code, bicycles: list);
  }
}

class CreateBicycleResponse {
  final Bicycle bicycle;
  final int code;
  final String message;
  CreateBicycleResponse({
    required this.bicycle,
    required this.code,
    required this.message,
  });
  factory CreateBicycleResponse.fromJson(dynamic json) {
    Bicycle bicycle = Bicycle.fromJson(json["bicycle"]);
    return CreateBicycleResponse(
      bicycle: bicycle,
      code: json["code"] ?? 300,
      message: json["message"] ?? "",
    );
  }
}
