// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_app/assets/color/colors.dart';

class WCheckBox extends StatelessWidget {
  bool isChecked;
  final Color checkBoxColor;
  final double size;

  WCheckBox({
    required this.isChecked,
    this.size = 20,
    this.checkBoxColor = Colors.blue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: size,
        width: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isChecked ? checkBoxColor :  white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            width: 1,
            color: isChecked ? Colors.transparent : grey
          )
        ),
        child: Icon(
          CupertinoIcons.checkmark_alt,
          size: size - 4,
          color: isChecked ? Colors.white : Colors.transparent,
        ),
      );
}
