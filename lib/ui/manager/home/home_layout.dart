import 'package:bicycle_rent/core/view_models/managet_view_model.dart';
import 'package:bicycle_rent/ui/manager/bikes/my_bick_layouts_manager.dart';
import 'package:bicycle_rent/ui/manager/bikes/my_bikes_layout.dart';
import 'package:bicycle_rent/ui/manager/inner_home/inner_home_layout.dart';
import 'package:bicycle_rent/ui/manager/inner_home/inner_home_manager.dart';
import 'package:bicycle_rent/ui/manager/places/places_layout.dart';
import 'package:bicycle_rent/ui/manager/settings/settings_layout.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:bicycle_rent/utils/constance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManagerHomeLayout extends GetWidget<ManagerViewModel> {
  const ManagerHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.onTab(0);
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
              InnerHomeManager(),
              BickManagerLayout(),
              PlaceLayout(),
              SettingsLayout(),
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
            _createNavigationItem(icon: Icons.place, label: "Stands"),
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
