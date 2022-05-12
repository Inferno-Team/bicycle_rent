import 'package:bicycle_rent/core/services/data_service.dart';
import 'package:bicycle_rent/models/login_response.dart';
import 'package:bicycle_rent/ui/customer/home/home_layout.dart';
import 'package:bicycle_rent/ui/manager/home/home_layout.dart';
import 'package:bicycle_rent/utils/cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController with CacheManager {
  String? email, password;
  final _service = DataService();
  final loginResponse = LoginResponse().obs;
  final _loading = 0.obs;
  final isLogged = false.obs;
  String? _userType;
  final visibilityIcon = true.obs;
  final keyboardOpen = false.obs;
  get loading => _loading.value;
  get userType => _userType;

  void login() async {
    _loading.value = 1;
    loginResponse.value = await _service.login(email!, password!);
    _loading.value = 2;
    if (loginResponse.value.code == 200) {
      await saveToken(loginResponse.value.token);
      await saveType(loginResponse.value.type);
      if (loginResponse.value.type == "manager") {
        Get.offAll(() => const ManagerHomeLayout());
      } else {
        Get.offAll(() => const CustomerHomeLayout());
      }
    } else {
      Fluttertoast.showToast(
        msg: loginResponse.value.message,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void signUp() async {}

  Future<void> checkLoginStatus() async {
    final token = getToken();
    final _type = getType();
    if (token != "") {
      isLogged.value = true;
      _userType = _type;
    }
    return await null;
  }
}
