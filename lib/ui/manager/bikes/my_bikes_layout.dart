import 'package:bicycle_rent/core/view_models/managet_view_model.dart';
import 'package:bicycle_rent/utils/constance.dart';
import 'package:bicycle_rent/ui/widgets/custom_bicycle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BikeLayout extends GetWidget<ManagerViewModel> {
  BikeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Obx(
      () {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) => CustomBicycle(
            bicycle: controller.bickes[index],
            onTap: () => controller.moveToBick(controller.bickes[index]),
          ),
          itemCount: controller.bickes.length,
        );
      },
    );
  }
}
