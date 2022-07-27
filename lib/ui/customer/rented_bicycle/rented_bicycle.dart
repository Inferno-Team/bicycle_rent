import 'package:bicycle_rent/core/view_models/customer_view_model.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RentedBicycleLayout extends GetWidget<CustomerViewModel> {
  const RentedBicycleLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (controller.index == 0) {
      controller.determinePosition();
      WidgetsFlutterBinding.ensureInitialized();
      controller.startBackgroundService();
    }
    return Obx(
      () => Stack(
        children: [
          Container(
            height: 24,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: controller.status,
                ),
                CustomText(
                  text: controller.steps,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25),
            height: size.height - 40,
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: controller.myPosition, zoom: 15),
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
              mapType: MapType.hybrid,
              markers: {
                Marker(
                  markerId: const MarkerId('currentPosition'),
                  infoWindow: const InfoWindow(title: 'Current Location'),
                  position: LatLng(controller.myPosition.latitude,
                      controller.myPosition.longitude),
                )
              },
            ),
          ),
          Positioned(
              child: FloatingActionButton(
                onPressed: () =>controller.scanStandQR(),
                child: Icon(Icons.access_alarm_sharp,),
              ),
              bottom: 2,
              left: 4),
        ],
      ),
    );
  }
}
