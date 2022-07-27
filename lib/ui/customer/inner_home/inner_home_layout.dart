import 'package:bicycle_rent/core/view_models/customer_view_model.dart';
import 'package:bicycle_rent/ui/customer/customer_scanner/scanner_layout_manager.dart';
import 'package:bicycle_rent/ui/customer/rented_bicycle/rented_bicycle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerHomeInnerLayout extends GetWidget<CustomerViewModel> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isRenting) {
        return RentedBicycleLayout();
      } else {
        return ScannerLayoutManager();
      }
    });
  }
}
