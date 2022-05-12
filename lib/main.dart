import 'package:bicycle_rent/core/view_models/login_view_model.dart';
import 'package:bicycle_rent/ui/customer/home/home_layout.dart';
import 'package:bicycle_rent/ui/login/login_layout.dart';
import 'package:bicycle_rent/ui/manager/home/home_layout.dart';
import 'package:bicycle_rent/ui/map/map_layout.dart';
import 'package:bicycle_rent/utils/binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LoginViewModel _loginViewModel = Get.put(
    LoginViewModel(),
    tag: 'login_view_model',
  );

  Future<void> checkLogin() async {
    await _loginViewModel.checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      home: Scaffold(
          body: FutureBuilder(
        future: checkLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return waitingView();
          } else {
            if (snapshot.hasError) {
              return errorView(snapshot);
            } else {
              return Obx(() {
                return _loginViewModel.isLogged.value
                    ? (_loginViewModel.userType == "manager"
                        ? ManagerHomeLayout()
                        : CustomerHomeLayout())
                    : Login();
              });
            }
          }
        },
      )),
    );
  }

  Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
  }

  Scaffold waitingView() {
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),
          Text('Loading...'),
        ],
      ),
    ));
  }
}
