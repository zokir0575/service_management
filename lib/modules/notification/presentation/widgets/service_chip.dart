import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/assets/constants/app_icons.dart';
import 'package:service_app/utils/text_styles.dart';

class ServiceChip extends StatelessWidget {
  final VoidCallback onTap;
  final bool isClicked;

  const ServiceChip({required this.onTap, this.isClicked = false, super.key});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isClicked ? lightPrimaryColor : whiteSmoke,
          border: isClicked ? Border.all(
            width: 1,
            color: primaryColor
          ) : null
        ),
        child: Row(
          children: [
            SvgPicture.asset(AppIcons.support),
            const SizedBox(width: 12,),
            Text('Netflix', style: darkStyle(context).copyWith(
                fontSize: 16, fontWeight: FontWeight.w400),)
          ],
        ),
      ),
    );
  }
}