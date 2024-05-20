import 'package:flutter/material.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/utils/text_styles.dart';

class ServiceNumbersPage extends StatefulWidget {
  final PageController controller;
  const ServiceNumbersPage({required this.controller, super.key});

  @override
  State<ServiceNumbersPage> createState() => _ServiceNumbersPageState();
}

class _ServiceNumbersPageState extends State<ServiceNumbersPage> {
  final List<String> titles = [
    'None to 3',
    '4 to 6',
    '7 to 10',
    'More than 10'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'How many subscription services are you currently using?',
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
            onTap: () => widget.controller.jumpToPage(2),
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
