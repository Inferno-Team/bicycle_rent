import 'package:bicycle_rent/core/view_models/delete_response.dart';
import 'package:bicycle_rent/models/style_response.dart';
import 'package:bicycle_rent/models/user_banned.dart';
import 'package:stack/stack.dart';
import 'package:bicycle_rent/core/services/data_service.dart';
import 'package:bicycle_rent/models/bicycle_response.dart';
import 'package:bicycle_rent/models/event_response.dart';
import 'package:bicycle_rent/models/stand_response.dart';
import 'package:bicycle_rent/ui/login/login_layout.dart';
import 'package:bicycle_rent/utils/cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:file_picker/file_picker.dart';

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
  final _userHistoryList = <UserHistory>[].obs;
  Stack<Object> _argsStack = Stack();
  final sendFile = {}.obs;
  final _bannedUsers = <UserBan>[].obs;
  final styles = <BicycleStyle>[].obs;
  final banUserCause = "".obs;
  final newStyle = BicycleStyle.empty();

  final isLoading = false.obs;
  final bickes = <Bicycle>[].obs;
  List<UserHistory> get userHistory => _userHistoryList.value;
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
  List<UserBan> get bannedUsers =>_bannedUsers.value;
  get args => _arguments.value;
  EventResponse get event => _recentEvent.value;
  final bicycleRemoveResponse = DeleteResponse.empty().obs;

  onTab(int index) {
    _tabIndex.value = index;
    _tabName.value = _titles[index];
    pageRoute.value = '/${_startPage[index].toLowerCase()}';
    isLoading.value = false;
    _argsStack = Stack();
    newStyle.empty();
    styles.value = <BicycleStyle>[];
    sendFile.value = {'stand': Stand(), 'style': BicycleStyle.empty()};
    if (index == 0) {
      getLastEvent();
    } else if (index == 1) {
      loadBickes();
    } else if (index == 2) {
      getStands();
    } else {
      getAllBannedUsers();
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

  moveToAddBickLayout() {
    pageRoute.value += "/add-bick";
  }

  moveToCurrentUserLocation(currentUser) {
    _arguments.value = currentUser;
    pageRoute.value += '/currentUser';
    _argsStack.push(currentUser);
  }

  moveToCurrentUserHistory(currentUser) {
    _arguments.value = currentUser;
    pageRoute.value += '/currentUserHistory';
    _argsStack.push(currentUser);
  }

  moveToUserBicycleHistory(UserHistory history) {
    _arguments.value = history.bicycle;
    pageRoute.value += '/userBicycleHistory';
    _argsStack.push(history.bicycle);
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

  getUserHistory(int userId) async {
    isLoading.value = true;
    _userHistoryList.value = await _service.getUserHistory(getToken(), userId);
    isLoading.value = false;
  }

  banUser(int userId) async {
    isLoading.value = true;
    await _service.banUser(getToken(), userId, banUserCause.value);
    isLoading.value = false;
    onBackPressed();
  }

  deleteBicycle(int bi_id) async {
    bicycleRemoveResponse.value =
        await _service.deleteBicycle(getToken(), bi_id);
  }

  openFileChooser() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      sendFile['image'] = file;
    } //   /
  }

  getAllStyles() async {
    styles.value = await _service.getAllStyles(getToken());
    styles.add(
        BicycleStyle(id: -2, name: "create new style", color: "", size: ""));
  }

  uploadNewBicycle() async {
    await _service.uploadNewBicycle(getToken(), sendFile);
  }

  void addNewStyle() async {
    styles.removeWhere((element) => element.id == -2);
//    styles.add(newStyle);
    final value = await _service.addNewStyle(getToken(), newStyle);
    if (value.code == 200) {
      getAllStyles();
    } else {
      Fluttertoast.showToast(msg: value.message);
    }
  }
  
  void getAllBannedUsers() async {
    isLoading.value = true;
    _bannedUsers.value = await _service.getAllBannedUsers(getToken());
    isLoading.value = false;
  }
}
