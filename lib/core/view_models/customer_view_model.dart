import 'package:bicycle_rent/core/services/user_data_service.dart';
import 'package:bicycle_rent/models/bicycle_response.dart';
import 'package:bicycle_rent/models/check_if_rent_response.dart';
import 'package:bicycle_rent/models/event_response.dart';
import 'package:bicycle_rent/models/rent_resopnse.dart';
import 'package:bicycle_rent/models/user.dart';
import 'package:bicycle_rent/ui/login/login_layout.dart';
import 'package:bicycle_rent/utils/cache_manager.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:stack/stack.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:workmanager/workmanager.dart';

class CustomerViewModel extends GetxController with CacheManager {
  final _tabName = "Home".obs;
  final _tabIndex = 0.obs;
  final _isRenting = false.obs;
  final _argument = Object().obs;
  final _userHistory = <UserHistory>[].obs;
  final _currentUser = CheckIfRentResponse.empty().obs;
  final _service = UserDataService();
  final _isLoading = false.obs;
  final _qrBicycle = Bicycle.empty().obs;
  final _user = User.empty().obs;
  final userFirstName = "".obs;
  final _titles = [
    "Home",
    "My History",
    "Settings",
  ];
  final _startPage = ['inner', 'bicycle', 'setting'];
  final pageRoute = "/".obs;
  final _myPosition = LatLng(0, 0).obs;
  Stack<Object> _argsStack = Stack();

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  final _status = '?'.obs;
  final _steps = '?'.obs;
  String get status => _status.value;
  String get steps => _steps.value;
  String get title => _tabName.value;
  int get index => _tabIndex.value;
  bool get isRenting => _isRenting.value;
  List<UserHistory> get userHistory => _userHistory;
  bool get isLoading => _isLoading.value;
  dynamic get arg => _argument.value;
  User get user => _user.value;
  LatLng get myPosition => _myPosition.value;
  @override
  void onInit() {
    super.onInit();
    initPlatformState();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    _status.value = event.status;
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    _steps.value = 'Step Count not available';
  }

  void onStepCount(StepCount event) {
    print(event);
    _steps.value = event.steps.toString();
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    _status.value = 'Pedestrian Status not available';
    print(_status);
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  onTab(int index) {
    _tabIndex.value = index;
    _tabName.value = _titles[index];
    pageRoute.value = '/${_startPage[index].toLowerCase()}';
    _isLoading.value = false;
    _argsStack = Stack();
    if (index == 0) {
      // getLastEvent();
      checkIfUserRent(getToken());
    } else if (index == 1) {
      getUserHistory();
    } else if (index == 2) {
      getUser();
    }
  }

  void checkIfUserRent(String token) async {
    _currentUser.value = await _service.checkIfRent(token);
    _isRenting.value = _currentUser.value.code == 200;
  }

  void getUserHistory() async {
    String token = getToken();
    _isLoading.value = true;
    _userHistory.value = await _service.getUserHistory(token);
    _isLoading.value = false;
  }

  Future<void> scanQR() async {
    try {
      String? value = await scanner.scan();
      if (value != null) {
        _isLoading.value = true;
        getBicyclerByIP(value);
        _isLoading.value = false;
      }
    } on PlatformException {
      Get.snackbar(
        'Error',
        "Something Went wrong.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return await null;
  }

  void getBicyclerByIP(String ip) async {
    String token = getToken();
    _qrBicycle.value = await _service.getBicyclerByIP(token, ip);
    if (_qrBicycle.value.id == -1) {
      Fluttertoast.showToast(msg: 'qr error bicycle not found.');
    } else {
      moveToQrBicycle(_qrBicycle.value);
    }
  }

  void moveToQrBicycle(value) {
    pageRoute.value += '/qr-bicycle';
    _argument.value = value;
  }

  void onBackPressed() {
    final routes = pageRoute.value.split("/");
    routes.remove(routes[routes.length - 1]);
    print(routes);
    String finalRoute = "";
    for (var i = 0; i < routes.length; i++) {
      if (routes[i] != "") {
        finalRoute += "/" + routes[i];
      }
    }
    if (routes.length == 1 && routes[0] == "") {
      finalRoute = "/";
    }
    print("finalRoute : $finalRoute");
    if (_argsStack.isNotEmpty) {
      _argsStack.pop();
      if (_argsStack.isNotEmpty) _argument.value = _argsStack.top();
    }
    pageRoute.value = finalRoute;
  }

  void rentThisBicycle(Bicycle bicycle) async {
    _isLoading.value = true;
    String token = getToken();
    RentResponse response = await _service.rentThisBicycle(token, bicycle.id);
    _isRenting.value = response.code == 200;
    Fluttertoast.showToast(msg: response.message);
    if (isRenting) {
      onBackPressed();
    }
  }

  determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    var x = await Geolocator.getCurrentPosition();
    LatLng lng = LatLng(x.latitude, x.longitude);
    _myPosition.value = lng;
    var token = getToken();
    /*  Geolocator.getPositionStream().listen((pos) async {
      await _service.updateMyLocation(pos.latitude, pos.longitude, token);
      _myPosition.value = LatLng(pos.latitude, pos.longitude);
    });  */
  }

  static const _fetchBackground = "fetchBackground";
  void _callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      switch (task) {
        case _fetchBackground:
          // Code to run in background
          //send current location to server
          var now = DateTime.now();
          print('hello from background service${now.minute}:${now.hour}');
          break;
      }
      return Future.value(true);
    });
  }

  void startBackgroundService() async {
    await Workmanager().initialize(
      _callbackDispatcher,
      isInDebugMode: true,
    );
    await Workmanager().registerPeriodicTask(
      "1",
      _fetchBackground,
      frequency: Duration(minutes: 20),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  returnBicycle(id) async {
    var token = getToken();
    await _service.returnBicycle(token, steps, id);
  }

  scanStandQR() async {
    try {
      String? value = await scanner.scan();
      if (value != null) {
        returnBicycle(value);
      }
    } on PlatformException {
      Get.snackbar(
        'Error',
        "Something Went wrong.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return await null;
  }

  void logOut() async {
    final response = await _service.logout(getToken());
    if (response.code == 200) {
      await removeToken();
      Get.offAll(() => Login());
    } else {
      Fluttertoast.showToast(msg: response.message);
    }
  }

  void getUser() async {
    _user.value = await _service.getUser(getToken());
    userFirstName.value = _user.value.firstName ?? "";
  }
}
