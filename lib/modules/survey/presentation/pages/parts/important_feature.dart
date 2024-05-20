import 'package:flutter/material.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/modules/navigation/presentation/home.dart';
import 'package:service_app/modules/navigation/presentation/navigator.dart';
import 'package:service_app/utils/text_styles.dart';

class ImportantFeature extends StatefulWidget {
  final PageController controller;

  const ImportantFeature({required this.controller, super.key});

  @override
  State<ImportantFeature> createState() => _ImportantFeatureState();
}

class _ImportantFeatureState extends State<ImportantFeature> {
  final List<String> titles = [
    'Simplicity and ease of use',
    'Detailed analytics of my spending',
    'Recommendations for similar services',
    'Options to cancel subscriptions directly through the app'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'How do you prefer to be notified about your subscription details?',
          style: darkStyle(context)
              .copyWith(fontWeight: FontWeight.w700, fontSize: 32),
        ),
        const SizedBox(
          height: 28,
        ),
        ...List.generate(
          4,
          (index) => WButton(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            margin: const EdgeInsets.only(bottom: 12),
            onTap: () => Navigator.pushAndRemoveUntil(context, fade(page: const NavigationScreen()), (route) => false),
            color: lightPrimary2,
            textStyle: darkStyle(context)
                .copyWith(fontWeight: FontWeight.w400, fontSize: 16),
            text: titles[index],
          ),
        ),
      ],
    );
  }
}
