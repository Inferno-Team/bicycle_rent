import 'package:bicycle_rent/core/view_models/customer_view_model.dart';
import 'package:bicycle_rent/ui/widgets/custom_button.dart';
import 'package:bicycle_rent/ui/widgets/custom_input.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:bicycle_rent/ui/widgets/custom_user_settings_item.dart';
import 'package:bicycle_rent/utils/constance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UseSettings extends GetWidget<CustomerViewModel> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Obx(
          () => Container(
            margin: const EdgeInsets.only(top: 32, left: 16, right: 16),
            child: Column(
              children: [
                Obx(
                  () => CustomUserSettingsItem(
                    title: controller.userFirstName.value,
                    icon: Icons.edit,
                    onTap: () {
                      Get.bottomSheet(EditFirstName(size),
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent);
                    },
                  ),
                ),
                CustomUserSettingsItem(
                  title: controller.userLastName.value,
                  icon: Icons.edit,
                  onTap: () {
                    Get.bottomSheet(EditLastName(size),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent);
                  },
                ),
                CustomUserSettingsItem(
                  title: controller.userEmail.value,
                  icon: Icons.edit,
                  onTap: () {
                    Get.bottomSheet(EditEmail(size),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent);
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      CustomButton(
                        onPressed: () {
                          Get.bottomSheet(RestPassword(size),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent);
                        },
                        text: "Reset Password",
                        width: size.width * 0.33,
                        hasBorder: false,
                        fontSize: 15,
                        fontColor: Colors.white,
                      ),
                      CustomButton(
                        onPressed: () => controller.editUser(),
                        text: "Save Changes",
                        hasBorder: false,
                        fontSize: 15,
                        fontColor: Colors.white,
                        width: size.width * 0.33,
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 8,
            right: 8,
            child: FloatingActionButton(
              onPressed: () => controller.logOut(),
              backgroundColor: primaryColor,
              child: Icon(
                Icons.logout,
                size: 22,
              ),
            ))
      ],
    );
  }

  Widget EditFirstName(Size size) {
    return Container(
      height: size.height * 0.334,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CustomText(
              text: "Edit First Name",
              fontSize: 16,
              alignment: Alignment.topCenter,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 16,
            ),
            CustomInput(
              text: "First Name",
              onChange: (value) {
                if (value != null) {
                  controller.userFirstName.value = value;
                }
              },
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  onPressed: () {
                    controller.userFirstName.value =
                        controller.user.firstName ?? "";
                    Get.back();
                  },
                  fontColor: Colors.white,
                  text: "Cancel",
                  hasBorder: false,
                  fontSize: 15,
                  width: size.width * 0.334,
                ),
                CustomButton(
                  onPressed: () {
                    Get.back();
                  },
                  fontColor: Colors.white,
                  text: "Save",
                  hasBorder: false,
                  fontSize: 15,
                  width: size.width * 0.334,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget EditLastName(Size size) {
    return Container(
      height: size.height * 0.334,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CustomText(
              text: "Edit Last Name",
              fontSize: 16,
              alignment: Alignment.topCenter,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 16,
            ),
            CustomInput(
              text: "Last Name",
              onChange: (value) {
                if (value != null) {
                  controller.userLastName.value = value;
                }
              },
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  onPressed: () {
                    controller.userLastName.value =
                        controller.user.lastName ?? "";
                    Get.back();
                  },
                  fontColor: Colors.white,
                  text: "Cancel",
                  hasBorder: false,
                  fontSize: 15,
                  width: size.width * 0.334,
                ),
                CustomButton(
                  onPressed: () {
                    Get.back();
                  },
                  fontColor: Colors.white,
                  text: "Save",
                  hasBorder: false,
                  fontSize: 15,
                  width: size.width * 0.334,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget EditEmail(Size size) {
    return Container(
      height: size.height * 0.334,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CustomText(
              text: "Edit Email",
              fontSize: 16,
              alignment: Alignment.topCenter,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 16,
            ),
            CustomInput(
              text: "Email",
              onChange: (value) {
                if (value != null) {
                  controller.userEmail.value = value;
                }
              },
              type: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  onPressed: () {
                    controller.userEmail.value = controller.user.email;
                    Get.back();
                  },
                  fontColor: Colors.white,
                  text: "Cancel",
                  hasBorder: false,
                  fontSize: 15,
                  width: size.width * 0.334,
                ),
                CustomButton(
                  onPressed: () {
                    Get.back();
                  },
                  fontColor: Colors.white,
                  text: "Save",
                  hasBorder: false,
                  fontSize: 15,
                  width: size.width * 0.334,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget RestPassword(Size size) {
     return Container(
      height: size.height * 0.334,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CustomText(
              text: "Rest Password",
              fontSize: 16,
              alignment: Alignment.topCenter,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 16,
            ),
            CustomInput(
              text: "Password",
              onChange: (value) {
                if (value != null) {
                  controller.userPassword.value = value;
                }
              },
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  onPressed: () {
                    controller.userPassword.value = "";
                    Get.back();
                  },
                  fontColor: Colors.white,
                  text: "Cancel",
                  hasBorder: false,
                  fontSize: 15,
                  width: size.width * 0.334,
                ),
                CustomButton(
                  onPressed: () {
                    controller.restPassword();
                    Get.back();
                  },
                  fontColor: Colors.white,
                  text: "Save",
                  hasBorder: false,
                  fontSize: 15,
                  width: size.width * 0.334,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  
  }
}
