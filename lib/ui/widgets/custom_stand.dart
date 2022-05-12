import 'package:bicycle_rent/core/view_models/managet_view_model.dart';
import 'package:bicycle_rent/models/stand_response.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bicycle_rent/utils/constance.dart';
class CustomStand extends GetWidget<ManagerViewModel> {
  final Stand stand;
  final bool odd;
  final double _iconSize = 15;
  final double _textSize = 15;
  CustomStand({required this.stand, this.odd = false});
  @override
  Widget build(BuildContext context) {
  
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        controller.moveToSand(stand);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        width: size.width / 2,
        decoration: BoxDecoration(
          borderRadius: odd
              ? const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(10))
              : const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(50)),
          color: primaryColor.withAlpha(175),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.storage_rounded,
                  color: Colors.redAccent,
                  size: _iconSize,
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomText(
                  text: stand.name,
                  fontSize: _textSize,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.redAccent,
                  size: _iconSize,
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomText(
                  text: stand.location,
                  fontSize: _textSize,
                  color: Colors.black,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.format_list_numbered_outlined,
                  color: Colors.redAccent,
                  size: _iconSize,
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomText(
                  text: "${stand.bicycleCount} bicycles",
                  fontSize: _textSize,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
