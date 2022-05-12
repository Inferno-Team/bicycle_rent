import 'dart:async';

import 'package:bicycle_rent/core/view_models/map_view_model.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLayout extends GetWidget<MapViewModel> {
  final LatLng pos;
  final String title;
  MapLayout(
      {this.pos = const LatLng(36.20957212121577, 37.126571586567756),
      this.title = 'Stand Location'});
  @override
  Widget build(BuildContext context) {
    // controller.openLocationStream();
    return Scaffold(
      body: Container(
        child: pos.latitude == 0 && pos.longitude == 0
            ? FutureBuilder(
                future: controller.determinePosition(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: snapshot.error.toString(),
                        ),
                      ],
                    );
                  } else {
                    return Obx(
                      () => Container(
                        margin: EdgeInsets.only(top: 24),
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: controller
                                  .convertPosition(snapshot.data as Position?),
                              zoom: 15),
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                          mapType: MapType.hybrid,
                          markers: {
                            if (controller.location != null)
                              Marker(
                                markerId: const MarkerId('currentPosition'),
                                infoWindow:
                                    const InfoWindow(title: 'Current Location'),
                                position: LatLng(controller.location.latitude,
                                    controller.location.longitude),
                              )
                            else
                              const Marker(
                                markerId: MarkerId('currentPosition'),
                                infoWindow:
                                    InfoWindow(title: 'Current Location'),
                                position: LatLng(0, 0),
                              )
                          },
                        ),
                      ),
                    );
                  }
                },
              )
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: pos,
                  zoom: 17,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('bick'),
                    infoWindow: InfoWindow(title: title),
                    position: pos,
                  ),
                },
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                mapType: MapType.hybrid,
                myLocationEnabled: true,
              ),
      ),
    );
  }
}
