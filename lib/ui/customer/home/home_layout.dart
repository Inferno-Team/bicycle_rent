import 'package:bicycle_rent/core/view_models/customer_view_model.dart';
import 'package:bicycle_rent/ui/customer/inner_home/inner_home_layout.dart';
import 'package:bicycle_rent/ui/customer/my_history/my_history_layout.dart';
import 'package:bicycle_rent/ui/customer/settings/user_settings.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:bicycle_rent/utils/constance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerHomeLayout extends GetWidget<CustomerViewModel> {
  const CustomerHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // controller.onTab(0);
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: CustomText(
            alignment: Alignment.centerLeft,
            text: controller.title,
            fontSize: 19,
            color: Colors.white,
          ),
        ),
        body: Obx(
          () => IndexedStack(
            children: [
              CustomerHomeInnerLayout(),
              MyHistoryLayout(),
              UseSettings()
            ],
            index: controller.index,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: unSelectedItemColor,
          selectedItemColor: selectedItemColor,
          onTap: controller.onTab,
          currentIndex: controller.index,
          items: [
            _createNavigationItem(icon: Icons.home, label: "Home"),
            _createNavigationItem(icon: Icons.pedal_bike, label: "Bikes"),
            _createNavigationItem(icon: Icons.settings, label: "Settings"),
          ],
        ),
      ),
    );
  }

  _createNavigationItem({icon, String? label}) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }
}
