import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bicycle_rent/core/view_models/login_view_model.dart';
import 'package:bicycle_rent/utils/constance.dart';

class CustomInput extends StatelessWidget {
  final String text;
  final String hint;
  final TextInputType type;
  final IconData? icon;
  final IconData? suffixIcon;
  final bool obscureText;
  final void Function(String?) onChange;
  final LoginViewModel controller = Get.find(tag: 'login_view_model');

  CustomInput(
      {Key? key,
      this.text = "",
      this.hint = "",
      required this.onChange,
      this.type = TextInputType.text,
      this.icon,
      this.suffixIcon,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          TextField(
            obscureText: obscureText,
            keyboardType: type,
            onChanged: onChange,
            decoration: InputDecoration(
              labelText: text,
              labelStyle: const TextStyle(
                color: Colors.white,
              ),
              floatingLabelStyle: const TextStyle(
                color: Colors.white,
              ),
              fillColor: inputFieldBackgroudColor,
              prefixIcon: Icon(icon, color: Colors.white),
              filled: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  controller.visibilityIcon.value =
                      !controller.visibilityIcon.value;
                },
                child: Icon(
                  suffixIcon,
                  size: 24.0,
                  color: Colors.white,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
