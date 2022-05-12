import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewModel extends GetxController {
  final _location = Rx<Position?>(null);
  final camera = CameraPosition(
          target: LatLng(36.20957212121577, 37.126571586567756), zoom: 11.5)
      .obs;
  get location => _location.value;
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return await Geolocator.getCurrentPosition();
    /* _location.value = await Geolocator.getCurrentPosition();
    
    */
  }

  LatLng convertPosition(Position? position) {
    if (position == null) return const LatLng(36.1864729, 37.1176499);
    return LatLng(position.latitude, position.longitude);
  }

  void openLocationStream() {
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      print(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');
      _location.value = position;
      if (position != null) {
        camera.value = CameraPosition(
          target: convertPosition(position),
          zoom: 15,
        );
      }
    });
  }
}
