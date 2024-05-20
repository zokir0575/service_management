import 'package:flutter/material.dart';
import 'package:service_app/assets/color/colors.dart';

TextStyle darkStyle(BuildContext context) {
  return Theme.of(context).textTheme.displayLarge!.copyWith(color: dark);
}

TextStyle blueStyle(BuildContext context) {
  return Theme.of(context).textTheme.displayLarge!.copyWith(color: primaryColor);
}

TextStyle greyStyle(BuildContext context) {
  return Theme.of(context).textTheme.displaySmall!.copyWith(color: grey);
}

TextStyle darkGreyStyle(BuildContext context) {
  return Theme.of(context).textTheme.headlineSmall!;
}

TextStyle whiteStyle(BuildContext context) {
  return Theme.of(context).textTheme.displayMedium!.copyWith(color:white);
}

TextStyle primaryStyle(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .headlineMedium!
      .copyWith(color: primaryColor);
}
