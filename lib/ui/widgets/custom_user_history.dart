import 'package:bicycle_rent/models/event_response.dart';
import 'package:bicycle_rent/utils/constance.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomUserHistory extends StatelessWidget {
  final UserHistory userHistory;
  final Function() onTap;

  const CustomUserHistory(
      {Key? key, required this.userHistory, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.85,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ClipRect(
            child: Banner(
              message: 'history',
              location: BannerLocation.topEnd,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(155),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(children: [
                    _createUserWidget(),
                    _createLastStand(),
                    _createOldStand(),
                    _createTimeStamps()
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _createUserWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: const Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
          ),
          CustomText(
            text:
                "${userHistory.user.firstName!}  ${userHistory.user.lastName!}",
          )
        ],
      ),
    );
  }

  _createLastStand() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: const Icon(
              Icons.location_on_outlined,
              color: Colors.redAccent,
            ),
          ),
          CustomText(
            text: userHistory.lastStand.name,
          )
        ],
      ),
    );
  }

  _createOldStand() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(children: [
        Icon(
          Icons.location_on_sharp,
          color: Colors.redAccent.withAlpha(155),
        ),
        CustomText(text: userHistory.oldStand.name)
      ]),
    );
  }

  _createTimeStamps() {
    var time = "";
    final date = userHistory.createAt;
    final now = DateTime.now();
    Duration compare = now.difference(date);
    if (compare.inDays > 30) {
      final months = compare.inDays % 30;
      time = "$months months ";
    } else if (compare.inDays > 0) {
      time = "${compare.inDays} days";
    } else {
      if (compare.inHours > 0) {
        time = "${compare.inHours} hours , ${compare.inMinutes - 60} minutes";
      } else {
        time = " ${compare.inMinutes} minutes";
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomText(
          text: "$time ago",
          fontSize: 13,
          color: const Color.fromARGB(255, 238, 236, 236),
        )
      ],
    );
  }
}
