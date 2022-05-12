import 'package:bicycle_rent/models/bicycle_response.dart';
import 'package:bicycle_rent/models/stand_response.dart';
import 'package:bicycle_rent/models/user.dart';
import 'package:flutter/cupertino.dart';

class CurrentUser {
  final User user;
  final Bicycle bicycle;
  final double long;
  final double lat;
  final DateTime createAt;
  CurrentUser({
    required this.user,
    required this.bicycle,
    required this.long, 
    required this.lat,
    required this.createAt,
  });
  factory CurrentUser.fromJson(dynamic json) {
    return CurrentUser(
        user: User.fromJson(json['user']),
        bicycle: Bicycle.fromJson(json['bicycle']),
        lat: json['lat'] ?? 0.0,
        long: json['long'] ?? 0.0,
        createAt: DateTime.parse(json['created_at'].toString()));
  }
}

class UserHistory {
  final User user;
  final Bicycle bicycle;
  final Stand oldStand;
  final Stand lastStand;
  final price;
  final String distance;
  final String time;
  final DateTime createAt;

  UserHistory(
      {required this.user,
      required this.bicycle,
      required this.oldStand,
      required this.lastStand,
      required this.price,
      required this.distance,
      required this.time,
      required this.createAt});
  factory UserHistory.fromJson(dynamic json) {
    final user = User.fromJson(json['user']);
    final oldStand = Stand.fromJson(json['old_stand']);
    final lastStand = Stand.fromJson(json['last_stand']);
    final bicycle = Bicycle.fromJson(json['bicycle']);
    return UserHistory(
        bicycle: bicycle,
        user: user,
        oldStand: oldStand,
        lastStand: lastStand,
        distance: json['distance'] ?? "0.0",
        price: json['price'] ?? 0.0,
        time: json['time'] ?? "0.0",
        createAt: DateTime.parse(json['created_at']));
  }
}

class EventResponse {
  final List<CurrentUser> currents;
  final List<UserHistory> history;

  EventResponse({required this.currents, required this.history});
  factory EventResponse.fromJson(dynamic json) {
    return EventResponse(
      currents: (json['current'] as List)
          .map((e) => CurrentUser.fromJson(e))
          .toList(),
      history: (json['history'] as List)
          .map((e) => UserHistory.fromJson(e))
          .toList(),
    );
  }
  factory EventResponse.empty() => EventResponse(currents: [], history: []);
}
