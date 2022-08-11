import 'package:bicycle_rent/core/view_models/managet_view_model.dart';
import 'package:bicycle_rent/ui/widgets/banned_user.dart';
import 'package:bicycle_rent/ui/widgets/custom_button.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsLayout extends GetWidget<ManagerViewModel> {
  SettingsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomText(
          text: "Banned Users",
          alignment: Alignment.topLeft,
          fontSize: 24,
          margin: const EdgeInsets.only(left: 20, top: 20),
        ),
        Container(
          margin: const EdgeInsets.only(top: 60,bottom: 40),
          child: Obx(
            () => ListView.builder(
              itemCount: controller.bannedUsers.length,
              itemBuilder: (context, index) =>
                  CustomBannedUser(userBan: controller.bannedUsers[index]),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: CustomButton(
            onPressed: () => {controller.logOut()},
            text: "Logout",
            hasBorder: true,
          ),
        ),
      ],
    );
  }
}
