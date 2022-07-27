import 'dart:io';

import 'package:bicycle_rent/core/view_models/managet_view_model.dart';
import 'package:bicycle_rent/models/stand_response.dart';
import 'package:bicycle_rent/models/style_response.dart';
import 'package:bicycle_rent/ui/widgets/custom_button.dart';
import 'package:bicycle_rent/ui/widgets/custom_input.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:bicycle_rent/utils/constance.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AddBickLayout extends GetWidget<ManagerViewModel> {
  @override
  Widget build(BuildContext context) {
    controller.getAllStyles();
    controller.getStands();
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Positioned(
              top: size.height * 0.08,
              left: size.width * 0.1,
              right: size.width * 0.1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade300,
                ),
                child: Obx(
                  () => GestureDetector(
                    onTap: () => controller.openFileChooser(),
                    child: controller.sendFile['image'] == null
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    (size.width - size.width * 0.05) * 0.1,
                                vertical: size.height * 0.08),
                            child: Icon(
                              Icons.add,
                              size: size.width * 0.2,
                            ),
                          )
                        : SizedBox(
                            height: size.height * 0.30,
                            width: size.width * 1,
                            child: Image.file(
                              File(
                                  (controller.sendFile['image'] as PlatformFile)
                                      .path!),
                              fit: BoxFit.fill,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            Container(
              height: size.height,
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.height * 0.60,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.4),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      CustomInput(
                        onChange: (text) => controller.sendFile['ppt'] = text,
                        text: "price Per Time",
                        type: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                      const SizedBox(height: 8),
                      CustomInput(
                        onChange: (text) => controller.sendFile['ppd'] = text,
                        text: "price Per Distnace",
                        type: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                      const SizedBox(height: 8),
                      CustomInput(
                        onChange: (text) => controller.sendFile['ip'] = text,
                        text: "Esp32 IP Address",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(
                            () => DropdownButton<BicycleStyle>(
                              items: _createStyleList(controller.styles.value),
                              onChanged: (object) {
                                if (object == null) return;
                                print(object.id);
                                if (object.id == -2) {
                                  Get.bottomSheet(
                                    AddStyleBottomSheetDialog(
                                        controller: controller, size: size),
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                  );
                                } else {
                                  controller.sendFile['style'] = object;
                                }
                              },
                              hint: Text(controller.sendFile['style'].name),
                            ),
                          ),
                          Obx(
                            () => DropdownButton<Stand>(
                              items: _createStandList(controller.stands),
                              onChanged: (object) =>
                                  controller.sendFile['stand'] = object,
                              hint: Text(controller.sendFile['stand'].name),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      CustomButton(
                        onPressed: () => controller.uploadNewBicycle(),
                        hasBorder: false,
                        text: "Add new bicycle",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<BicycleStyle>> _createStyleList(
      List<BicycleStyle> value) {
    return value
        .map(
          (v) => DropdownMenuItem<BicycleStyle>(
            value: v,
            child: Text(v.name),
          ),
        )
        .toList();
  }

  List<DropdownMenuItem<Stand>> _createStandList(List<Stand> stands) {
    return stands
        .map((s) => DropdownMenuItem<Stand>(
              value: s,
              child: Text(s.name),
            ))
        .toList();
  }
}

class AddStyleBottomSheetDialog extends StatelessWidget {
  final ManagerViewModel controller;
  final Size size;

  const AddStyleBottomSheetDialog(
      {Key? key, required this.controller, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        height: size.height * 0.667,
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
                    text: "Add New Style",
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
                        controller.newStyle.name = _new;
                      }
                    },
                    text: "Style Name",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInput(
                    onChange: (String? _new) {
                      if (_new != null) {
                        controller.newStyle.color = _new;
                      }
                    },
                    text: "Style Color",
                    icon: Icons.color_lens,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInput(
                    onChange: (String? _new) {
                      if (_new != null) {
                        controller.newStyle.size = _new;
                      }
                    },
                    text: "Style Size",
                    icon: Icons.two_wheeler_rounded,
                  ),
                   const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    onPressed: () {
                      controller.addNewStyle();
                      Get.close(1);
                    },
                    text: "Add New Style",
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
