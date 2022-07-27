import 'package:bicycle_rent/core/view_models/managet_view_model.dart';
import 'package:bicycle_rent/models/stand_response.dart';
import 'package:bicycle_rent/ui/widgets/custom_bicycle.dart';
import 'package:bicycle_rent/utils/constance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomStandItem extends GetWidget<ManagerViewModel> {
  final Stand stand;

  const CustomStandItem({required this.stand, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(stand.location);
    controller.getStandBikes(stand.id);
    return Stack(
      children: [
        Obx(() { 
          return ListView.builder(
            itemBuilder: (context, index) {
              return Center(
                child: CustomBicycle(
                  bicycle: controller.bicycles[index],
                  onTap: () =>
                      controller.moveToBicycle(controller.bicycles[index]),
                      onLongPress: (){},
                ),
              );
            },
            itemCount: controller.bicycles.length,
          );
        }),
        Positioned(
          bottom: 10,
          right: 10,
          child: FloatingActionButton(
            onPressed: () {
              controller.moveToMap(stand.lat, stand.long);
            },
            child: const Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            backgroundColor: loginColors[2],
          ),
        ),
      ],
    );
  }
}
