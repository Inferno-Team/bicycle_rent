import 'package:flutter/cupertino.dart';

class Esp32User {
  final String email;
  final String password;
  final String ip;
  Esp32User({
    this.email = "",
    this.ip = "",
    this.password = "",
  });
  factory Esp32User.fromJson(dynamic json) {
    var email = json['emai'] ?? '';
    var ip = json['ip'] ?? '';
    var password = json['password'] ?? '';
    return Esp32User(email: email, ip: ip, password: password);
  }
}
