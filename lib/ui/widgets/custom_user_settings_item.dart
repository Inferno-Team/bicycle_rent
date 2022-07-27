import 'package:bicycle_rent/ui/widgets/custom_input.dart';
import 'package:bicycle_rent/ui/widgets/custom_text.dart';
import 'package:bicycle_rent/utils/constance.dart';
import 'package:flutter/material.dart';

class CustomUserSettingsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;

  const CustomUserSettingsItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            GestureDetector(
              onTap: onTap,
              child: Icon(
                icon,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
