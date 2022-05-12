import 'package:bicycle_rent/core/services/data_service.dart';
import 'package:bicycle_rent/core/view_models/managet_view_model.dart';
import 'package:bicycle_rent/models/bicycle_response.dart';
import 'package:bicycle_rent/ui/widgets/custom_button.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleBickLayout extends StatelessWidget {
  final Bicycle bicycle;
  final Function() onPress;
  SingleBickLayout({required this.bicycle, required this.onPress});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      color: Colors.white,
      child: Column(
        children: [
          const CustomText(
            text: "Selected Bicycle",
            fontSize: 21,
            color: Colors.black,
            margin: EdgeInsets.fromLTRB(15, 15, 5, 10),
          ),
          CustomText(
            text: bicycle.name,
            fontSize: 17,
            color: Colors.black26,
            margin: const EdgeInsets.fromLTRB(15, 0, 5, 10),
          ),
          Container(
            margin: const EdgeInsets.all(25),
            child: Hero(
              tag: bicycle.name,
              child: Image.network("${DataService.apiUrl}${bicycle.imgURL}"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BicycleInfoCircle(
                text: bicycle.style!.color,
                icon: Icons.color_lens,
                color: colorFromHex(bicycle.style!.color),
              ),
              BicycleInfoCircle(
                text: bicycle.style!.size,
                icon: Icons.two_wheeler_rounded,
                color: Colors.redAccent,
              ),
              BicycleInfoCircle(
                text: "${bicycle.pricePerDistance} SP",
                icon: Icons.timeline,
                color: Colors.lightGreen,
              ),
              BicycleInfoCircle(
                text: "${bicycle.pricePerTime} SP",
                icon: Icons.timer,
                color: Colors.lightGreen,
              ),
            ],
          ),
          CustomButton(
            text: "Find on Map",
            onPressed: onPress,
            width: 200,
          ),
        ],
      ),
    );
  }
}

class BicycleInfoCircle extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  BicycleInfoCircle(
      {required this.text, required this.icon, this.color = Colors.black});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: 70,
      width: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
          ),
          CustomText(
            text: text.replaceFirst("#", ""),
            alignment: Alignment.center,
            color: color,
          )
        ],
      ),
    );
  }
}

Color colorFromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
