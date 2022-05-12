import 'package:bicycle_rent/core/view_models/managet_view_model.dart';
import 'package:bicycle_rent/ui/manager/bikes/my_bikes_layout.dart';
import 'package:bicycle_rent/ui/manager/bikes/single_bike_layout.dart';
import 'package:bicycle_rent/ui/map/map_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BickManagerLayout extends GetWidget<ManagerViewModel> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.onBackPressed();
        return false;
      },
      child: Obx(() {
        if (controller.index != 1) return Container();
         
        if (controller.pageRoute.value == '/bicycle') {
         
          return BikeLayout();
        } else if (controller.pageRoute.value == '/bicycle/bick') {
          return SingleBickLayout(
            bicycle: controller.args,
            onPress: () => controller.moveToMap(
              controller.args.lat,
              controller.args.long,
            ),
          );
        } else if (controller.pageRoute.value == '/bicycle/bick/map') {
          return MapLayout(
            pos: controller.args,
            title: 'Bicycle Location',
          );
        } else {
          return Container(child: Text('no child'),);
        }
      }),
    );
  }
}
