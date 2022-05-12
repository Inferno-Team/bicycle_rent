import 'package:bicycle_rent/core/view_models/managet_view_model.dart';
import 'package:bicycle_rent/ui/manager/inner_home/inner_home_layout.dart';
import 'package:bicycle_rent/ui/map/map_layout.dart';
import 'package:flutter/material.dart';
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
        } else if (controller.pageRoute.value == '/inner/currentUser') {
          return MapLayout(
            title: "Current User",
            pos: LatLng(controller.args.lat,controller.args.long),
          );
        }
        return Container(
          child: Text('no child'),
        );
      }),
    );
  }
}
