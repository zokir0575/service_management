import 'package:flutter/material.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/modules/onboarding/presentation/pages/first_step.dart';
import 'package:service_app/modules/onboarding/presentation/pages/second_step.dart';
import 'package:service_app/modules/onboarding/presentation/pages/third_step.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controller = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:   EdgeInsets.fromLTRB(16, MediaQuery.paddingOf(context).top + 8, 16, MediaQuery.paddingOf(context).bottom +  20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 4,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    height: 4,
                    color: pageIndex > 0 ? primaryColor : lightPrimaryColor,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    height: 4,
                    color: pageIndex > 1 ? primaryColor : lightPrimaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 26,),
            Expanded(
              child: PageView(
                onPageChanged: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                children: [
                  FirstStep(
                    controller: controller,
                  ),
                  SecondStep(
                    controller: controller,
                  ),
                  ThirdStep(controller: controller),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
