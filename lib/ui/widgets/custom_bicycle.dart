import 'package:bicycle_rent/core/services/data_service.dart';
import 'package:bicycle_rent/core/view_models/managet_view_model.dart';
import 'package:bicycle_rent/models/bicycle_response.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomBicycle extends StatelessWidget {
  final Bicycle bicycle;
  final Function() onTap;
  const CustomBicycle({required this.bicycle,required this.onTap});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ClipRect(
          child: Banner(
            message: bicycle.isAvailable ? "Available" : "Not Available",
            color: bicycle.isAvailable ? Colors.greenAccent : Colors.redAccent,
            textStyle: const TextStyle(fontSize: 9),
            location: BannerLocation.topEnd,
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    width: size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 1.6, vertical: .1),
                    height: 10,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(17),
                          bottomRight: Radius.circular(17)),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(94, 128, 255, 128),
                          Color.fromARGB(72, 70, 255, 64),
                          Color.fromARGB(61, 49, 245, 32),
                          Color.fromARGB(41, 53, 197, 16),
                        ],
                        stops: [0.1, 0.3, 0.5, 0.7],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: bicycle.name,
                          fontSize: 21,
                          color: Colors.black,
                          alignment: Alignment.topLeft,
                        ),
                        CustomText(
                          text:
                              "${bicycle.style!.color} , ${bicycle.style!.size}",
                          color: Colors.black26,
                          fontSize: 15,
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(left: 4, top: 4),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 10.0),
                          child: Hero(
                            tag: bicycle.name,
                            child: Image.network(
                                "${DataService.apiUrl}${bicycle.imgURL}"),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
