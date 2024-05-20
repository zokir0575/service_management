import 'package:flutter/material.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/utils/text_styles.dart';

class GoalPage extends StatefulWidget {
  final PageController controller;

  const GoalPage({required this.controller, super.key});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  final List<String> titles = [
    'To keep track of all my subscription expenses',
    'To find new subscription services that interest me',
    'To reduce my spending on unnecessary subscriptions',
    'To get reminders about payment due dates'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'What is your primary goal for using this subscription management app?',
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
            onTap: () => widget.controller.jumpToPage(1),
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
