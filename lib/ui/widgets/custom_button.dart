import 'package:bicycle_rent/utils/constance.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool hasBorder;
  final double width;
  final double fontSize;
  final Color fontColor;
  const CustomButton(
      {Key? key,
      this.text = "",
      required this.onPressed,
      this.hasBorder = false,
      this.width = 0,
      this.fontColor = Colors.black,
      this.fontSize = 18.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: width == 0 ? size.width : width,
      child: Material(
        child: GestureDetector(
          onTap: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              color: hasBorder ? Colors.white : loginColors[2],
              borderRadius: BorderRadius.circular(10),
              border: hasBorder
                  ? Border.all(
                      color: loginColors[2],
                      width: 1.0,
                    )
                  : const Border.fromBorderSide(BorderSide.none),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 60.0,
                child: Center(
                  child: CustomText(
                    text: text,
                    color: fontColor,
                    fontSize: fontSize,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
