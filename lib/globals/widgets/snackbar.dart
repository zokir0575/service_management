import 'package:flutter/material.dart';
import 'package:service_app/utils/text_styles.dart';

showInfoSnackBar(BuildContext context) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(
    margin: EdgeInsets.fromLTRB(
        16, 0, 16, 16 + MediaQuery.of(context).padding.bottom),
    behavior: SnackBarBehavior.floating,
    content: Text(
      "Thanks for rating:)",
      style: whiteStyle(context)
          .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
    ),
    backgroundColor: Colors.green,
    elevation: 10,showCloseIcon: true,
  ));
}