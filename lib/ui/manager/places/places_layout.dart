import 'package:bicycle_rent/core/view_models/managet_view_model.dart';
import 'package:bicycle_rent/ui/manager/bikes/single_bike_layout.dart';
import 'package:bicycle_rent/ui/manager/places/inner_place_layout.dart';
import 'package:bicycle_rent/ui/map/map_layout.dart';
import 'package:bicycle_rent/ui/widgets/custom_stand_item.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaceLayout extends GetWidget<ManagerViewModel> {
  PlaceLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.onBackPressed();
        return false;
      },
      child: Obx(() {
        if (controller.index != 2) return Container();
        if (controller.pageRoute.value == '/place') {
          return InnerPlacePage();
        } else if (controller.pageRoute.value == '/place/stand') {
          return CustomStandItem(stand: controller.args);
        } else if (controller.pageRoute.value == '/place/stand/bicycle') {
          return SingleBickLayout(
            bicycle: controller.args,
            onPress: () => controller.moveToMap(
              controller.args.lat,
              controller.args.long,
            ),
          );
        } else if (controller.pageRoute.value.contains('/map')) {
          String title = "Stand Location";
          if (controller.pageRoute.value.contains('bicycle')) {
            title = "Bicycle Location";
          }
          return MapLayout(
            pos: controller.args,
            title: title,
          );
        } else {
          return const Center(
            child: CustomText(text: 'No Child'),
          );
        }
      }),
    );
  }
}
