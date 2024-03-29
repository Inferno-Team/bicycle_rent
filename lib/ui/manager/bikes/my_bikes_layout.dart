import 'package:bicycle_rent/core/view_models/managet_view_model.dart';
import 'package:bicycle_rent/models/bicycle_response.dart';
import 'package:bicycle_rent/ui/widgets/custom_button.dart';
import 'package:bicycle_rent/ui/widgets/custom_input.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:bicycle_rent/utils/constance.dart';
import 'package:bicycle_rent/ui/widgets/custom_bicycle.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class BikeLayout extends GetWidget<ManagerViewModel> {
  BikeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        }
        return Stack(
          children: [
            ListView.builder(
              itemBuilder: (context, index) => CustomBicycle(
                bicycle: controller.bickes[index],
                onTap: () => controller.moveToBick(controller.bickes[index]),
                onLongPress: () {
                  Get.bottomSheet(DeleteBickBottomSheetDialog(
                      size: size,
                      controller: controller,
                      bicycle: controller.bickes[index]));
                },
              ),
              itemCount: controller.bickes.length,
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                margin: const EdgeInsets.all(10),
                child: FloatingActionButton(
                  backgroundColor: primaryColor,
                  onPressed: () => controller.moveToAddBickLayout(),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class DeleteBickBottomSheetDialog extends StatelessWidget {
  final Size size;
  final ManagerViewModel controller;
  final Bicycle bicycle;

  const DeleteBickBottomSheetDialog(
      {Key? key,
      required this.size,
      required this.controller,
      required this.bicycle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        height: size.height * 0.35,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
          ),
        ),
        child: Column(children: [
          const SizedBox(
            height: 25,
          ),
          const Center(
            child: CustomText(
              text: "Do you want to delete this bicycle ?",
              margin: EdgeInsets.all(16),
              alignment: Alignment.center,
            ),
          ),
          Container(
            width: size.width * 0.8,
            margin: const EdgeInsets.only(top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: size.width * 0.3,
                  height: size.height * 0.0667,
                  child: CustomButton(
                    onPressed: () async {
                      // controller.banUser(user.user.id);
                      print(bicycle.id);
                      await controller.deleteBicycle(bicycle.id);
                      controller.loadBickes();
                      Get.close(1);
                    },
                    text: "Yes",
                    hasBorder: false,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.3,
                  height: size.height * 0.0667,
                  child: CustomButton(
                    onPressed: () => Get.close(1),
                    text: "No",
                    hasBorder: true,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
