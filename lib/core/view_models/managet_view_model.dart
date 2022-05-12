import 'package:bicycle_rent/core/services/data_service.dart';
import 'package:bicycle_rent/models/bicycle_response.dart';
import 'package:bicycle_rent/models/event_response.dart';
import 'package:bicycle_rent/models/stand_response.dart';
import 'package:bicycle_rent/ui/login/login_layout.dart';
import 'package:bicycle_rent/utils/cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stack/stack.dart';

class ManagerViewModel extends GetxController with CacheManager {
  final _tabIndex = 0.obs;
  final _service = DataService();
  final _stands = <Stand>[].obs;
  final _bicycles = <Bicycle>[].obs;
  final _tabName = "Home".obs;
  final newStand = Stand().obs;
  final pageRoute = "/".obs;
  final _arguments = Object().obs;
  final _recentEvent = EventResponse.empty().obs;
  Stack<Object> _argsStack = Stack();

  final isLoading = false.obs;
  final bickes = <Bicycle>[].obs;

  final _titles = [
    "Home",
    "My Bikes",
    "Stands Place",
    "Settings",
  ];
  final _startPage = ['inner', 'bicycle', 'place', 'setting'];

  int get index => _tabIndex.value;
  String get title => _tabName.value;
  List<Stand> get stands => _stands.value;
  List<Bicycle> get bicycles => _bicycles.value;
  get args => _arguments.value;
  EventResponse get event => _recentEvent.value;

  onTab(int index) {
    _tabIndex.value = index;
    _tabName.value = _titles[index];
    pageRoute.value = '/${_startPage[index].toLowerCase()}';
    isLoading.value = false;
    _argsStack = Stack();
    if (index == 0) {
      getLastEvent();
    } else if (index == 1) {
      loadBickes();
    } else if (index == 2) {
      getStands();
    }
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

  void addNewStand() async {
    final response = await _service.createNewStand(getToken(), newStand.value);
    _stands.add(response.stand);
    Fluttertoast.showToast(msg: response.message);
  }

  void moveToSand(Stand stand) {
    pageRoute.value += '/stand';
    _argsStack.push(stand);
    _arguments.value = _argsStack.top();
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
      if (_argsStack.isNotEmpty) _arguments.value = _argsStack.top();
    }
    pageRoute.value = finalRoute;
  }

  void getStandBikes(int standId) async {
    var token = getToken();

    var response = await _service.getStandBicycle(standId, token);
    if (response.code == 200) {
      _bicycles.value = response.bicycles;
    } else {
      Fluttertoast.showToast(msg: 'Error on retreving bicycles');
    }
  }

  void moveToBicycle(Bicycle b) {
    pageRoute.value += '/bicycle';
    _argsStack.push(b);
    _arguments.value = b;
  }

  void moveToMap(String lat, String long) {
    _arguments.value = LatLng(double.parse(lat), double.parse(long));
    pageRoute.value += "/map";
    _argsStack.push(LatLng(double.parse(lat), double.parse(long)));
  }

  moveToBick(bick) {
    _arguments.value = bick;
    pageRoute.value += '/bick';
    _argsStack.push(bick);
  }

  moveToCurrentUser(currentUser) {
    _arguments.value = currentUser;
    pageRoute.value += '/currentUser';
    _argsStack.push(currentUser);
  }

  void getStands() async {
    _stands.value = [];
    isLoading.value = true;
    final standResponse = await _service.getAllStands(getToken());
    isLoading.value = false;

    if (standResponse.code == 200) _stands.value = standResponse.stands;
  }

  void loadBickes() async {
    isLoading.value = true;
    bickes.value = await _service.getAllBicycles(getToken());
    isLoading.value = false;
  }

  getLastEvent() async {
    isLoading.value = true;
    _recentEvent.value = await _service.getRecentEvent(getToken());
    isLoading.value = false;
  }
}
