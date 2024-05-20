import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/assets/constants/app_icons.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/modules/navigation/presentation/home.dart';
import 'package:service_app/modules/navigation/presentation/navigator.dart';
import 'package:service_app/utils/text_styles.dart';

class SurveyResultScreen extends StatefulWidget {
  const SurveyResultScreen({super.key});

  @override
  State<SurveyResultScreen> createState() => _SurveyResultScreenState();
}

class _SurveyResultScreenState extends State<SurveyResultScreen> {
  bool _showFirst = false;
  bool _firstComplete = false;
  bool _showSecond = false;
  bool _secondComplete = false;
  bool _showThird = false;
  bool _thirdComplete = false;

  @override
  void initState() {
    super.initState();
    _startSequence();
  }

  void _startSequence() async {
    setState(() {
      _showFirst = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _firstComplete = true;
    });

    setState(() {
      _showSecond = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _secondComplete = true;
    });

    // Show the third indicator and wait
    setState(() {
      _showThird = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _thirdComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _thirdComplete
          ? WButton(
              onTap: () => Navigator.pushAndRemoveUntil(context,
                  fade(page: const NavigationScreen()), (route) => false),
              text: 'Continue',
              margin: EdgeInsets.fromLTRB(
                  16, 0, 16, MediaQuery.paddingOf(context).bottom + 12),
            )
          : const SizedBox(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            16, MediaQuery.paddingOf(context).top + 12, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(11),
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: lightPrimaryColor.withOpacity(.3),
              ),
              child: _thirdComplete
                  ? SvgPicture.asset(AppIcons.check)
                  : const CircularProgressIndicator(
                      color: primaryColor,
                    ),
            ),
            const SizedBox(
              height: 28,
            ),
            Text(
              _thirdComplete ? 'Done!' : 'Please wait',
              style: _thirdComplete
                  ? blueStyle(context)
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 18)
                  : darkStyle(context)
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              _thirdComplete
                  ? 'Your profile is set up and ready to go!'
                  : 'We will create a profile to make it as convenient for you as possible.',
              textAlign: TextAlign.center,
              style: greyStyle(context).copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: _thirdComplete ? 16 : 14),
            ),
            const Spacer(),
            Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: lightPrimary2,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: _firstComplete
                        ? SvgPicture.asset(AppIcons.check)
                        : _showFirst
                            ? const CircularProgressIndicator(
                                color: primaryColor,
                              )
                            : const SizedBox.shrink(),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Personalizing your dashboard',
                    style: blueStyle(context)
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: _showSecond ? lightPrimary2 : white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: _secondComplete
                        ? SvgPicture.asset(AppIcons.check)
                        : _showSecond
                            ? const CircularProgressIndicator(
                                color: primaryColor,
                              )
                            : const SizedBox.shrink(),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Optimizing notifications',
                    style: blueStyle(context)
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: _showThird ? lightPrimary2 : white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: _thirdComplete
                        ? SvgPicture.asset(AppIcons.check)
                        : _showThird
                            ? const CircularProgressIndicator(
                                color: primaryColor,
                              )
                            : const SizedBox.shrink(),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Text(
                      'Tailoring subscription recommendations to fit your preferences',
                      style: blueStyle(context)
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
