import 'package:bicycle_rent/models/user.dart';

class UserBan {
  final String cause;
  final User user;
  final String createAt;

  UserBan({this.cause = "", required this.user, this.createAt = ""});

  factory UserBan.fromJson(dynamic json){
    return UserBan(
      cause: json['cause'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      createAt: json['created_at'] as String,
    );
  }
}
