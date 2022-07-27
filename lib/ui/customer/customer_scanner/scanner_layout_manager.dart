import 'package:bicycle_rent/core/view_models/customer_view_model.dart';
import 'package:bicycle_rent/ui/customer/customer_scanner/bicycle_shower.dart';
import 'package:bicycle_rent/ui/customer/customer_scanner/customer_scanner_layout.dart';
import 'package:bicycle_rent/ui/manager/bikes/single_bike_layout.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ScannerLayoutManager extends GetWidget<CustomerViewModel> {
  const ScannerLayoutManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.pageRoute.value == '/inner') {
        return const CustomerScannerLayout();
      } else if (controller.pageRoute.value == '/inner/qr-bicycle') {
        return RentBickLayout(bicycle: controller.arg, onPress: () {
          controller.rentThisBicycle(controller.arg);
        });
      } else {
        return const Center(
          child: Text('no child'),
        );
      }
    });
  }
}
