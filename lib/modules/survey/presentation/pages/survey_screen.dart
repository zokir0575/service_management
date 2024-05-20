import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/assets/constants/app_icons.dart';
import 'package:service_app/globals/widgets/w_scale.dart';
import 'package:service_app/modules/onboarding/presentation/pages/first_step.dart';
import 'package:service_app/modules/survey/presentation/pages/parts/categories.dart';
import 'package:service_app/modules/survey/presentation/pages/parts/goal.dart';
import 'package:service_app/modules/survey/presentation/pages/parts/important_feature.dart';
import 'package:service_app/modules/survey/presentation/pages/parts/number_of_service.dart';
import 'package:service_app/modules/survey/presentation/pages/parts/preference_notification.dart';
import 'package:service_app/utils/text_styles.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  PageController controller = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    print(pageIndex);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding:   EdgeInsets.fromLTRB(16, 0, 16, MediaQuery.paddingOf(context).bottom + 20),
        child: Row(
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
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                height: 4,
                color: pageIndex > 2 ? primaryColor : lightPrimaryColor,
              ),
            ), const SizedBox(
              width: 12,
            ),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                height: 4,
                color: pageIndex > 3 ? primaryColor : lightPrimaryColor,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, MediaQuery.paddingOf(context).top + 8,
            16, MediaQuery.paddingOf(context).bottom + 20),
        child: Column(
          children: [
            WScaleAnimation(
              onTap: () => pageIndex > 0 ? controller.jumpToPage(pageIndex -1) : Navigator.pop(context),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.back,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Back',
                    style: blueStyle(context)
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
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
                 GoalPage(controller: controller),
                  ServiceNumbersPage(controller: controller),
                  CategoryPage(controller: controller),
                  PreferredNotificationPage(controller: controller),
                  ImportantFeature(controller: controller),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
