import 'package:bicycle_rent/models/bicycle_response.dart';
import 'package:bicycle_rent/models/check_if_rent_response.dart';
import 'package:bicycle_rent/models/event_response.dart';
import 'package:bicycle_rent/models/message_response.dart';
import 'package:bicycle_rent/models/rent_resopnse.dart';
import 'package:bicycle_rent/models/return_response.dart';
import 'package:bicycle_rent/models/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class UserDataService {
  static const String apiUrl = "http://192.168.43.113:8000";

  // static const String apiUrl = "http://192.168.1.110:8000";
  // static const String apiUrl = "http://192.168.1.7:8000";
  final String route = "/api";

  Future<CheckIfRentResponse> checkIfRent(String token) async {
    String routeName = '/check_user_if_renting';
    Uri uri = Uri.parse(apiUrl + route + routeName);
    http.Response response = await http.post(uri, headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    });
    try {
      final body = await json.decode(response.body);
      return CheckIfRentResponse.fromJson(body);
    } catch (e) {
      print('costumer check if rent error $e');

      return CheckIfRentResponse.empty();
    }
  }

  Future<List<UserHistory>> getUserHistory(String token) async {
    String routeName = '/get_my_history';
    Uri uri = Uri.parse(apiUrl + route + routeName);
    http.Response response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    });
    try {
      final body = await json.decode(response.body);
      return (body as List).map((e) => UserHistory.fromJson(e)).toList();
    } catch (e) {
      print('costumer get history error $e');
      return [];
    }
  }

  Future<Bicycle> getBicyclerByIP(String token, String ip) async {
    String routeName = '/get_bicycle_by_ip';
    Uri uri = Uri.parse(apiUrl + route + routeName + '/$ip');
    print(uri.path);
    http.Response response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    });
    try {
      final body = await json.decode(response.body);
      return Bicycle.fromJson(body);
    } catch (e) {
      print('costumer get history error $e');
      return Bicycle.empty();
    }
  }

  Future<RentResponse> rentThisBicycle(String token, int id) async {
    String routeName = '/rent_bicycle';
    Uri uri = Uri.parse(apiUrl + route + routeName);

    http.Response response = await http.post(uri, headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    }, body: {
      'bi_id': "$id"
    });
    try {
      final body = await json.decode(response.body);
      print(body);
      return RentResponse.fromJson(body);
    } catch (e) {
      print('customer rent bicycle error $e');
      return RentResponse.empty();
    }
  }

  updateMyLocation(lat, lng, token) async {
    Uri uri = Uri.parse(apiUrl + route + '/update_current_location');
    try {
      http.Response response = await http.post(uri,
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
          body: {'lat': "$lat", 'long': "$lng"});
      var body = await json.decode(response.body);
      print(body);
    } catch (e) {
      print("Error $e");
    }
  }

  Future<ReturnResponse> returnBicycle(
      String token, String steps, lastStandId) async {
    Uri uri = Uri.parse(apiUrl + route + '/return_bicycle');
    try {
      http.Response response = await http.post(uri,
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
          body: {"step_count": steps, "last_stand": "$lastStandId"});
      var body = await json.decode(response.body);
      print(body);
      return ReturnResponse.fromJson(body);
    } catch (e) {
      print("Error $e");
      return ReturnResponse.empty();
    }
  }

  Future<MessageResponse> logout(token) async {
    var loginRoute = '/logout';
    final Uri uri = Uri.parse(apiUrl + route + loginRoute);
    http.Response response = await http.post(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    try {
      if (response.statusCode == 200) {
        return MessageResponse.fromJson(await json.decode(response.body));
      } else {
        print('something wrong ${response.statusCode}');
        // print('something wrong $uri');
        // print('something wrong ${response.body}');
        print('something wrong ${response.headers}');
        return MessageResponse();
      }
    } catch (e) {
      print('something wrong $e');
      return MessageResponse();
    }
  }

  Future<User> getUser(token) async {
    Uri uri = Uri.parse(apiUrl + route + '/get_user');
    try {
      http.Response response = await http.post(
        uri,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );
      var body = await json.decode(response.body);
      return User.fromJson(body);
    } catch (e) {
      print("Error $e");
      return User.empty();
    }
  }

  editUser(
      String token, String firstName, String lastName, String email) async {
    Uri uri = Uri.parse(apiUrl + route + '/edit_user');
    try {
      http.Response response = await http.post(
        uri,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        body: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
        },
      );
      var body = await json.decode(response.body);
      print(body);
    } catch (e) {
      print("Error $e");
    }
  }

  resetPassword(String token, String password) async{
    Uri uri = Uri.parse(apiUrl + route + '/reset_password');
    try {
      http.Response response = await http.post(
        uri,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        body: {
          'password': password,
        },
      );
      var body = await json.decode(response.body);
      print(body);
    } catch (e) {
      print("Error $e");
    }
  }
}
