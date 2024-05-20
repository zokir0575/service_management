import 'package:flutter/material.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/assets/constants/app_images.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/utils/text_styles.dart';

class FirstStep extends StatelessWidget {
  final PageController controller;

  const FirstStep({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Make Your Service Management Easier',
          style: darkStyle(context)
              .copyWith(fontSize: 32, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 32,
        ),
        Container(
          height: 210,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
                image: AssetImage(AppImages.firstStep), fit: BoxFit.fill),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          'Be aware of your spending on services and subscriptions',
          style: darkStyle(context)
              .copyWith(fontWeight: FontWeight.w400, fontSize: 16),
        ),
        const Spacer(),
        WButton(
          onTap: () {
            controller.jumpToPage(1);

          },
          text: 'Next',
          textStyle: blueStyle(context).copyWith(fontWeight: FontWeight.w600, fontSize: 16),
          color: lightPrimaryColor,
        ),
      ],
    );
  }
}
