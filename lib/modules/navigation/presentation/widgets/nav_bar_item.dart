import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/modules/navigation/domain/entities/navbar.dart';
import 'package:service_app/utils/text_styles.dart';

class NavItemWidget extends StatelessWidget {
  final int currentIndex;
  final NavBar navBar;

  const NavItemWidget({
    required this.navBar,
    required this.currentIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 11),
      child: Column(
        children: [
          Center(
            child: SvgPicture.asset(
              navBar.icon,
              color: currentIndex == navBar.id ? primaryColor : grey,
              height: 24,
              width: 24,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            navBar.title,
            style: greyStyle(context).copyWith(
                fontSize: 12,
                color: currentIndex == navBar.id ? primaryColor : null,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
