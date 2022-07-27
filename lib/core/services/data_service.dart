import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bicycle_rent/core/view_models/delete_response.dart';
import 'package:bicycle_rent/models/bicycle_response.dart';
import 'package:bicycle_rent/models/event_response.dart';
import 'package:bicycle_rent/models/login_response.dart';
import 'package:bicycle_rent/models/message_response.dart';
import 'package:bicycle_rent/models/stand_response.dart';
import 'package:bicycle_rent/models/style_response.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class DataService {
  static const String apiUrl = "http://192.168.43.114:8000";
  // static const String apiUrl = "http://192.168.1.110:8000";
  // static const String apiUrl = "http://192.168.1.7:8000";
  final String route = "/api";

  Future<LoginResponse> login(String email, String password) async {
    var loginRoute = '/login';

    final Uri uri = Uri.parse(apiUrl + route + loginRoute);
    http.Response response =
        await http.post(uri, body: {'email': email, 'password': password});
    try {
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(await json.decode(response.body));
      } else {
        print('something wrong $uri');
        return LoginResponse();
      }
    } catch (e) {
      print('something wrong $e');
      return LoginResponse();
    }
  }

  Future<MessageResponse> logout(token) async {
    var loginRoute = '/logout';
    final Uri uri = Uri.parse(apiUrl + route + loginRoute);
    print('Bearer $token');
    http.Response response = await http.post(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      'Content-type': 'application/json',
      'Accept': 'application/json',
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

  Future<StandResponse> getAllStands(token) async {
    var routeName = "/get_all_stands";
    final Uri uri = Uri.parse(apiUrl + route + routeName);
    http.Response response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    });
    try {
      if (response.statusCode == 200) {
        return StandResponse.fromJson(await json.decode(response.body));
      } else {
        print('something wrong ${response.statusCode}');

        print('something wrong ${response.body}');
        return StandResponse(code: response.statusCode, stands: []);
      }
    } catch (e) {
      print('something wrong $e');
      return StandResponse(code: 403, stands: []);
    }
  }

  Future<CreateStandResponse> createNewStand(token, Stand stand) async {
    var routeName = "/create_stand";
    final Uri uri = Uri.parse(apiUrl + route + routeName);
    http.Response response = await http.post(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      // HttpHeaders.contentTypeHeader: 'application/json',
      // HttpHeaders.acceptHeader: 'application/json'
    }, body: {
      'name': stand.name,
      'location': stand.location,
      'lat': stand.lat,
      'long': stand.long,
      'bicycle_count': "${stand.bicycleCount}",
    });
    try {
      if (response.statusCode == 200) {
        return CreateStandResponse.fromJson(await json.decode(response.body));
      } else {
        print('something wrong ${response.statusCode}');

        print('something wrong ${response.body}');
        return CreateStandResponse(
            code: response.statusCode, message: "Error", stand: Stand());
      }
    } catch (e) {
      print('something wrong $e');
      return CreateStandResponse(code: 403, message: "Error2", stand: Stand());
    }
  }

  Future<CreateBicycleResponse?> createNewBike(token, Bicycle bicycle) async {
    var routeName = "/create_stand";
    final Uri uri = Uri.parse(apiUrl + route + routeName);
    /* request [name , file(image) , lat , long , price_per_time,
                                     price_per_distnace , style_id , stand_id , is_sport,
                                     esp32 email , esp32 password ,esp_ip ]*/

    http.Response response = await http.post(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    }, body: {
      'name': bicycle.name,
      'lat': bicycle.lat,
      'long': bicycle.long,
      'price_per_time': bicycle.pricePerTime,
      'price_per_distnace': bicycle.pricePerDistance,
      'style_id': bicycle.style!.id,
      'stand_id': bicycle.style!.id, // it will change to stand
      'is_sport': false,
      'email': bicycle.esp32!.email,
      'password': bicycle.esp32!.password,
      'esp_ip': bicycle.esp32!.ip
    });
    try {
      if (response.statusCode == 200) {
        return CreateBicycleResponse.fromJson(await json.decode(response.body));
      } else {
        print('something wrong ${response.statusCode}');

        print('something wrong ${response.body}');
        return CreateBicycleResponse(
            code: response.statusCode, message: "Error", bicycle: Bicycle());
      }
    } catch (e) {
      print('something wrong $e');
      return CreateBicycleResponse(
          code: 403, message: "Error2", bicycle: Bicycle());
    }
  }

  Future<BicycleResponse> getStandBicycle(id, token) async {
    var routeName = "/get_stand_bicycles/$id";
    final Uri uri = Uri.parse(apiUrl + route + routeName);
    http.Response response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    try {
      if (response.statusCode == 200) {
        var _json = await json.decode(response.body);
        return BicycleResponse.fromJson(_json);
      } else {
        print('something wrong ${response.statusCode}');

        print('something wrong ${response.body}');
        return BicycleResponse(code: response.statusCode, bicycles: []);
      }
    } catch (e) {
      print('something wrong $e');
      return BicycleResponse(code: 403, bicycles: []);
    }
  }

  Future<List<Bicycle>> getAllBicycles(token) async {
    var routeName = "/get_all_bicycle";
    final Uri uri = Uri.parse(apiUrl + route + routeName);
    http.Response response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    try {
      List<dynamic> _json = await json.decode(response.body);

      return _json.map((e) => Bicycle.fromJson(e)).toList();
    } catch (e) {
      print('Error on geting bickes $e');
      return List.empty();
    }
  }

  Future<EventResponse> getRecentEvent(token) async {
    var routeName = "/recent_events";
    final Uri uri = Uri.parse(apiUrl + route + routeName);
    http.Response response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    try {
      final _json = await json.decode(response.body);
      return EventResponse.fromJson(_json);
    } catch (e) {
      print('Error on geting recent events $e');
      return EventResponse.empty();
    }
  }

  Future<List<UserHistory>> getUserHistory(token, id) async {
    var routeName = "/get_user_history";
    final Uri uri = Uri.parse(apiUrl + route + routeName + "?userId=$id");
    http.Response response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    try {
      final _json = await json.decode(response.body);
      return (_json as List).map((e) => UserHistory.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<void> banUser(token, id, cause) async {
    var routeName = "/ban_user";
    final Uri uri = Uri.parse(apiUrl + route + routeName);
    http.Response response = await http.post(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    }, body: {
      'id': "$id",
      'cause': cause
    });
    try {
      final _json = await json.decode(response.body);
      print(_json);
    } catch (e) {
      print(e);
    }
  }

  Future<List<BicycleStyle>> getAllStyles(token) async {
    var routeName = "/get_all_styles";
    final Uri uri = Uri.parse(apiUrl + route + routeName);
    http.Response response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    try {
      final _json = await json.decode(response.body);
      return (_json as List).map((e) => BicycleStyle.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future uploadNewBicycle(String token, Map sendFile) async {
    /* request [ file(image) , price_per_time, price_per_distnace ,
                 style_id , stand_id , is_sport,esp_ip ]*/
    var routeName = "/create_bicycle";
    final Uri uri = Uri.parse(apiUrl + route + routeName);
    var request = http.MultipartRequest("POST", uri);
    request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    request.fields['price_per_time'] = sendFile['ppt'];
    request.fields['price_per_distance'] = sendFile['ppd'];
    request.fields['esp_ip'] = sendFile['ip'];
    request.fields['style_id'] = sendFile['style'].id.toString();
    request.fields['stand_id'] = sendFile['stand'].id.toString();
    File file = File((sendFile['image'] as PlatformFile).path!);
    Uint8List list = await file.readAsBytes();
    print(list);
    var img = await http.MultipartFile.fromPath('image', file.path);
    request.files.add(img);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
    var _json = await json.decode(result);
    print(_json);
  }

  Future<CreateStyleResponse> addNewStyle(
      String token, BicycleStyle style) async {
    // request [name , color , size ]
    var routeName = "/create_style";
    final Uri uri = Uri.parse(apiUrl + route + routeName);
    http.Response response = await http.post(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    }, body: {
      'name': style.name,
      'color': style.color,
      'size': style.size,
    });
    try {
      if (response.statusCode == 200) {
        return CreateStyleResponse.fromJson(await json.decode(response.body));
      } else {
        print('something wrong ${response.statusCode}');

        print('something wrong ${response.body}');
        return CreateStyleResponse(
            code: response.statusCode,
            message: "Error",
            style: BicycleStyle.empty());
      }
    } catch (e) {
      print('something wrong $e');
      return CreateStyleResponse(
          code: 403, message: "Error2", style: BicycleStyle.empty());
    }
  }

  Future<LoginResponse> signUp(
      String email, String password, String nationalId) async {
    var loginRoute = '/signup';

    final Uri uri = Uri.parse(apiUrl + route + loginRoute);
    http.Response response = await http.post(uri, body: {
      'email': email,
      'password': password,
      'national_id': nationalId,
    });
    try {
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(await json.decode(response.body));
      } else {
        print('something wrong $uri');
        return LoginResponse();
      }
    } catch (e) {
      print('something wrong $e');
      return LoginResponse();
    }
  }

  Future<DeleteResponse> deleteBicycle(String token, int bi) async {
    var loginRoute = '/delete_bick';

    final Uri uri = Uri.parse(apiUrl + route + loginRoute);
    http.Response response = await http.post(uri, body: {
      'bid': bi.toString(),
    },
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    try {
      if (response.statusCode == 200) {
        var _json = await json.decode(response.body);
        print(_json);
        return DeleteResponse.fromJson(_json);
      } else {
        print('something wrong $uri');
        return DeleteResponse.empty();
      }
    } catch (e) {
      print('something wrong $e');
      return DeleteResponse.empty();
    }
  }
}
