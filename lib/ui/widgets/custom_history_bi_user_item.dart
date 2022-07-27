import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:bicycle_rent/utils/constance.dart';
import 'package:flutter/material.dart';

class CustomHistoryBiUserItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Size size;

  const CustomHistoryBiUserItem(
      {super.key, required this.title, required this.icon,required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: size.width/3,
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomText(
              text: title,
              fontSize: 17,
              alignment: Alignment.topCenter,
              
            ),
            Icon(
              icon,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}
