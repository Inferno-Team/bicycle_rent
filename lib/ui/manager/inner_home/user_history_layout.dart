import 'package:bicycle_rent/core/view_models/managet_view_model.dart';
import 'package:bicycle_rent/models/event_response.dart';
import 'package:bicycle_rent/models/user.dart';
import 'package:bicycle_rent/ui/widgets/custom_button.dart';
import 'package:bicycle_rent/ui/widgets/custom_input.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:bicycle_rent/ui/widgets/custom_user_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserHistoryLayout extends GetWidget<ManagerViewModel> {
  final CurrentUser user;

  UserHistoryLayout({required this.user});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    controller.getUserHistory(user.user.id);
    return Obx(
      () => ListView.builder(
        itemCount: controller.userHistory.length,
        itemBuilder: (contextBuilder, index) => CustomUserHistory(
          userHistory: controller.userHistory[index],
          onTap: () => controller
              .moveToUserBicycleHistory(controller.userHistory[index]),
          onLongTap: () {
            Get.bottomSheet(
              BanBottomSheetDialog(
                  size: size, controller: controller, user: user),
              backgroundColor: Colors.transparent,
              isScrollControlled: false,
            );
          },
        ),
      ),
    );
  }
}

class BanBottomSheetDialog extends StatelessWidget {
  final Size size;
  final ManagerViewModel controller;
  final CurrentUser user;

  const BanBottomSheetDialog(
      {Key? key,
      required this.size,
      required this.controller,
      required this.user})
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
              text: "Do you want to ban this user ?",
              margin: EdgeInsets.all(16),
              alignment: Alignment.center,
            ),
          ),
          SizedBox(
            width: size.width * 0.8,
            child: CustomInput(
              onChange: (text) {
                if (text == null) return;
                controller.banUserCause.value = text;
              },
              text: "optional: Cause",
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
                    onPressed: () {
                      controller.banUser(user.user.id);
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
