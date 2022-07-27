import 'package:bicycle_rent/core/view_models/managet_view_model.dart';
import 'package:bicycle_rent/utils/constance.dart';
import 'package:bicycle_rent/ui/widgets/custom_current_user.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:bicycle_rent/ui/widgets/custom_user_history.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class InnerHomeLayout extends GetWidget<ManagerViewModel> {
  InnerHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.index != 0) return Container();
      if (controller.isLoading.value) {
        return const Center(
            child: CircularProgressIndicator(
          color: primaryColor,
        ));
      } else {
        return ListView(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 10, 16, 4),
              child: const CustomText(
                text: "Recent Events",
                fontSize: 17,
              ),
            ),
            for (var current in controller.event.currents)
              CustomCurrentUser(
                currentUser: current,
                onTap: () => controller.moveToCurrentUserLocation(current),
                onUserTap: () => controller.moveToCurrentUserHistory(current),
              ),
            for (var history in controller.event.history)
              CustomUserHistory(
                userHistory: history,
                onTap: () => controller.moveToUserBicycleHistory(history),
              )
          ],
        );
      }
    });
  }
}
