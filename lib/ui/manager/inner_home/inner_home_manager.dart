import 'package:bicycle_rent/core/view_models/managet_view_model.dart';
import 'package:bicycle_rent/ui/manager/bikes/single_bike_layout.dart';
import 'package:bicycle_rent/ui/manager/inner_home/inner_home_layout.dart';
import 'package:bicycle_rent/ui/manager/inner_home/user_history_layout.dart';
import 'package:bicycle_rent/ui/map/map_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InnerHomeManager extends GetWidget<ManagerViewModel> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.onBackPressed();
        return false;
      },
      child: Obx(() {
        if (controller.index != 0) return Container();
        if (controller.pageRoute.value == '/inner') {
          return InnerHomeLayout();
        } else if (controller.pageRoute.value == '/inner/currentUser' ||
            controller.pageRoute.value.endsWith('map')) {
          var pos;
          if (controller.args is LatLng) {
            pos = controller.args;
          } else {
            pos = LatLng(controller.args.lat, controller.args.long);
          }
          return MapLayout(
            title: "Current User",
            pos: pos,
          );
        } else if (controller.pageRoute.value == '/inner/currentUserHistory') {
          return UserHistoryLayout(
            user: controller.args,
          );
        } else if (controller.pageRoute.value.endsWith('userBicycleHistory')) {
          return SingleBickLayout(
            bicycle: controller.args,
            onPress: () => controller.moveToMap(
              controller.args.lat,
              controller.args.long,
            ),
          );
        } else {
          SystemNavigator.pop();
          return const Text('');
        }
      }),
    );
  }
}
