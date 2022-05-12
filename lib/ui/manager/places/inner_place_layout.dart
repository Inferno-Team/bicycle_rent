import 'package:bicycle_rent/core/view_models/managet_view_model.dart';
import 'package:bicycle_rent/utils/constance.dart';
import 'package:bicycle_rent/ui/widgets/custom_bottom_sheet_dialog.dart';
import 'package:bicycle_rent/ui/widgets/custom_stand.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InnerPlacePage extends GetWidget<ManagerViewModel> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          } else {
            return GridView.builder(
              itemBuilder: (context, index) => CustomStand(
                stand: controller.stands[index],
                odd: (index % 2) != 0,
              ),
              itemCount: controller.stands.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
              ),
            );
          }
        }),
        Positioned(
          bottom: 10,
          right: 10,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton(
              backgroundColor: primaryColor,
              onPressed: () {
                Get.bottomSheet(
                  BottomSheetDialog(size: size, controller: controller),
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                );
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
