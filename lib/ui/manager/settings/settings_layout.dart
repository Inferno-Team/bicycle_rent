import 'package:bicycle_rent/core/view_models/managet_view_model.dart';
import 'package:bicycle_rent/ui/widgets/custom_button.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsLayout extends GetWidget<ManagerViewModel> {
  SettingsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
         
          CustomButton(
            onPressed: () => {controller.logOut()},
            text: "Logout",
            hasBorder: true,
          ),
        ],
      ),
    );
  }
}
