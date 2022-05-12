import 'package:bicycle_rent/core/view_models/managet_view_model.dart';
import 'package:bicycle_rent/ui/widgets/custom_button.dart';
import 'package:bicycle_rent/ui/widgets/custom_input.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetDialog extends StatelessWidget {
  const BottomSheetDialog({
    Key? key,
    required this.size,
    required this.controller,
  }) : super(key: key);

  final Size size;
  final ManagerViewModel controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        height: size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
              child: Column(
                children: [
                  const CustomText(
                    text: "Add New Stand",
                    color: Colors.black,
                    alignment: Alignment.center,
                    fontSize: 21,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomInput(
                    icon: Icons.storage_rounded,
                    onChange: (String? _new) {
                      if (_new != null) {
                        controller.newStand.value.name = _new;
                      }
                    },
                    text: "Stand Name",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInput(
                    onChange: (String? _new) {
                      if (_new != null) {
                        controller.newStand.value.location = _new;
                      }
                    },
                    text: "Stand Location",
                    icon: Icons.location_on_outlined,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInput(
                    onChange: (String? _new) {
                      if (_new != null) {
                        controller.newStand.value.lat = _new;
                      }
                    },
                    text: "Lat",
                    icon: Icons.location_searching,
                    type: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: false,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInput(
                    type: const TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    onChange: (String? _new) {
                      if (_new != null) {
                        controller.newStand.value.long = _new;
                      }
                    },
                    text: "Long",
                    icon: Icons.location_searching,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInput(
                    type: const TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    onChange: (String? _new) {
                      if (_new != null) {
                        controller.newStand.value.bicycleCount =
                            int.parse(_new);
                      }
                    },
                    text: "Bicycle Count",
                    icon: Icons.format_list_numbered_outlined,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    onPressed: () {
                      controller.addNewStand();
                      Get.close(1);
                    },
                    text: "Add New Stand",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
