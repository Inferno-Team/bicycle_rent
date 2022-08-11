import 'package:bicycle_rent/models/user_banned.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:bicycle_rent/utils/constance.dart';
import 'package:flutter/material.dart';

class CustomBannedUser extends StatelessWidget {
  final void Function()? onTap;
  final UserBan userBan;

  const CustomBannedUser({super.key, this.onTap, required this.userBan});

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
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(155),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(children: [
                _createUserWidget(),
                _createCauseWidget(),
                _createTimeStampsWidget()
              ]),
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
            text: "${userBan.user.firstName!}  ${userBan.user.lastName!}",
          )
        ],
      ),
    );
  }

  _createCauseWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: const Icon(
              Icons.message_rounded,
              color: Colors.white,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: userBan.cause,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  _createTimeStampsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomText(
          text: userBan.createAt,
          fontSize: 13,
          color: const Color.fromARGB(255, 238, 236, 236),
        )
      ],
    );
  }
}
