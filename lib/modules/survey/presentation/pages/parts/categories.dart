import 'package:flutter/material.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/utils/text_styles.dart';

class CategoryPage extends StatefulWidget {
  final PageController controller;

  const CategoryPage({required this.controller, super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final List<String> titles = [
    'Entertainment (e.g., streaming platforms)',
    'Utilities (e.g., electricity, water, internet)',
    'Health and wellness (e.g., gym, meditation apps)',
    'Learning and productivity (e.g., online courses, software tools)'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Which categories of services are you most interested in managing?',
          style: darkStyle(context)
              .copyWith(fontWeight: FontWeight.w700, fontSize: 32),
        ),
        const SizedBox(
          height: 28,
        ),
        ...List.generate(
          4,
          (index) => WButton(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            margin: const EdgeInsets.only(bottom: 12),
            onTap: () => widget.controller.jumpToPage(3),
            color: lightPrimary2,
            alignment: Alignment.centerLeft,
            textStyle: darkStyle(context)
                .copyWith(fontWeight: FontWeight.w400, fontSize: 16),
            text: titles[index],
          ),
        ),
      ],
    );
  }
}
