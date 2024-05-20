import 'package:flutter/material.dart';
import 'package:service_app/assets/constants/app_images.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/modules/navigation/presentation/navigator.dart';
import 'package:service_app/modules/survey/presentation/pages/survey_screen.dart';
import 'package:service_app/utils/text_styles.dart';

class ThirdStep extends StatelessWidget {
  final PageController controller;

  const ThirdStep({required this.controller,super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Don't miss payments and keep your records",
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
                image: AssetImage(AppImages.thirdStep), fit: BoxFit.fill),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          "Don't be afraid to miss a charge, we will notify you in advance",
          style: darkStyle(context)
              .copyWith(fontWeight: FontWeight.w400, fontSize: 16),
        ),
        const Spacer(),
        WButton(
          onTap: () {
            Navigator.push(context, fade(page: const SurveyScreen()));
          },
          text: 'Start',
        ),
      ],
    );
  }
}
