import 'package:bicycle_rent/core/view_models/customer_view_model.dart';
import 'package:bicycle_rent/ui/widgets/custom_button.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerScannerLayout extends GetWidget<CustomerViewModel> {
  const CustomerScannerLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: ()async {
         controller.onBackPressed();
        return true;
      },
      child: Stack(
        children: [
          CustomText(
            text: 'Scan Bicycle\'s QR',
            alignment: Alignment.topCenter,
            fontSize: 21,
            color: Colors.black,
            margin: EdgeInsets.only(top: size.height / 3.6, left: 12, right: 12),
          ),
          Container(
            margin: EdgeInsets.only(
                top: size.height / 2.6,
                left: size.width / 4,
                right: size.width / 4),
            child: CustomButton(
              onPressed: () =>controller.scanQR(),
              hasBorder: false,
              text: "Open QR Scanner",
              width: size.width / 2,
            ),
          )
        ],
      ),
    );
  }
}
