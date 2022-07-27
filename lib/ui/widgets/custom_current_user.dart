import 'package:bicycle_rent/models/event_response.dart';
import 'package:bicycle_rent/utils/constance.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomCurrentUser extends StatelessWidget {
  final CurrentUser currentUser;
  final Function() onTap;
  final Function() onUserTap;
  const CustomCurrentUser(
      {Key? key,
      required this.currentUser,
      required this.onTap,
      required this.onUserTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.85,
      margin: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ClipRect(
            child: Banner(
              message: 'current',
              location: BannerLocation.topEnd,
              color: Colors.redAccent,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(31, 202, 122, 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(children: [
                    _createUserWidget(onUserTap),
                    _createBicycleName(),
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

  _createUserWidget(onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                  "${currentUser.user.firstName!}  ${currentUser.user.lastName!}",
            )
          ],
        ),
      ),
    );
  }

  _createBicycleName() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: const Icon(
              Icons.pedal_bike,
              color: Colors.blueGrey,
            ),
          ),
          CustomText(
            text: currentUser.bicycle.name,
          )
        ],
      ),
    );
  }

  _createTimeStamps() {
/*     var time = "";
    final date = currentUser.createAt;
    final now = DateTime.now();
    Duration compare = now.difference(date);
    if (compare.inDays >= 30) {
      final months = compare.inDays ~/ 30;
      time = "$months months ";
      if (compare.inDays % 30 > 0) time += ",${compare.inDays % 30} days";
    } else {
      if (compare.inDays > 0)
        time = "${compare.inDays} days";
      else {
        if (compare.inHours == 0) {
          time = "${compare.inMinutes} minutes";
        } else {
          time = "${compare.inHours} hours ";
          if (compare.inMinutes % 60 > 0)
            time += ", ${compare.inMinutes % 60} minutes";
        }
      }
    } */
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomText(
          text: currentUser.createAt,
          fontSize: 13,
          color: const Color.fromARGB(255, 238, 236, 236),
        )
      ],
    );
  }
}
