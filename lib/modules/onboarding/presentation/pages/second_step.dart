import 'package:flutter/material.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/assets/constants/app_images.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/utils/text_styles.dart';

class SecondStep extends StatelessWidget {
  final PageController controller;

  const SecondStep({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Don't let your money go to no one knows where",
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
                image: AssetImage(AppImages.secondStep), fit: BoxFit.fill),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          'Calculate your spending on services and subscriptions months in advance',
          style: darkStyle(context)
              .copyWith(fontWeight: FontWeight.w400, fontSize: 16),
        ),
        const Spacer(),
        WButton(
          onTap: () {
            controller.jumpToPage(2);
          },
          text: 'Next',
          textStyle: blueStyle(context)
              .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
          color: lightPrimaryColor,
        ),
      ],
    );
  }
}
