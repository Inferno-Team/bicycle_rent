import 'package:bicycle_rent/core/view_models/customer_view_model.dart';
import 'package:bicycle_rent/core/view_models/login_view_model.dart';
import 'package:bicycle_rent/core/view_models/managet_view_model.dart';
import 'package:bicycle_rent/core/view_models/map_view_model.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    /*  Get.lazyPut(() => LoginViewModel());
    Get.lazyPut(() => ManagerViewModel());
    Get.lazyPut(() => CustomerViewModel());
    Get.lazyPut(() => MapViewModel()); */

    Get.put(LoginViewModel());
    Get.put(ManagerViewModel());
    Get.put(CustomerViewModel());
    Get.put(MapViewModel());
  }
}
