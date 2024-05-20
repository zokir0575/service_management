import 'package:flutter/material.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/utils/text_styles.dart';

class PreferredNotificationPage extends StatefulWidget {
  final PageController controller;

  const PreferredNotificationPage({required this.controller, super.key});

  @override
  State<PreferredNotificationPage> createState() =>
      _PreferredNotificationPageState();
}

class _PreferredNotificationPageState extends State<PreferredNotificationPage> {
  final List<String> titles = [
    'Email notifications',
    'Push notifications on my device',
    'Text messages',
    'No preference, as long as I receive the updates'
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
            onTap: () => widget.controller.jumpToPage(4),
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
