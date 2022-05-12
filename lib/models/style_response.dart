class BicycleStyle {
  final String name;
  final String color;
  final String size;
  final int id;
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
}
