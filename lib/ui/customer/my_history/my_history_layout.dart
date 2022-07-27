import 'package:bicycle_rent/core/view_models/customer_view_model.dart';
import 'package:bicycle_rent/models/event_response.dart';
import 'package:bicycle_rent/ui/widgets/custom_history_bi_user_item.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:bicycle_rent/ui/widgets/custom_user_history.dart';
import 'package:bicycle_rent/utils/constance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHistoryLayout extends GetWidget<CustomerViewModel> {
  const MyHistoryLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Obx(
      () => (controller.isLoading)
          ? const Center(
              child: CircularProgressIndicator(
              color: primaryColor,
            ))
          : ListView.builder(
              itemCount: controller.userHistory.length,
              itemBuilder: (_, index) => CustomUserHistory(
                userHistory: controller.userHistory[index],
                onTap: () => {
                  Get.bottomSheet(
                    InfoBottomSheet(
                        userHistory: controller.userHistory[index], size: size),
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                  )
                },
              ),
            ),
    );
  }
}

class InfoBottomSheet extends StatelessWidget {
  final UserHistory userHistory;
  final Size size;

  const InfoBottomSheet(
      {super.key, required this.userHistory, required this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.5,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
      ),
      child: Stack(
        children: [
          CustomText(
            text: userHistory.bicycle.name,
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top: 16),
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
          Container(
              margin: const EdgeInsets.only(top: 48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomHistoryBiUserItem(
                        title: userHistory.oldStand.location,
                        icon: Icons.location_off_sharp,
                        size: size,
                      ),
                      CustomHistoryBiUserItem(
                          title: userHistory.lastStand.location,
                          icon: Icons.location_on,
                          size: size),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomHistoryBiUserItem(
                          title: "${userHistory.distance} M",
                          icon: Icons.space_bar_rounded,
                          size: size),
                      CustomHistoryBiUserItem(
                        title: userHistory.time,
                        icon: Icons.alarm,
                        size: size,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomHistoryBiUserItem(
                        title: "${userHistory.price} S.P",
                        icon: Icons.payments_sharp,
                        size: size,
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
