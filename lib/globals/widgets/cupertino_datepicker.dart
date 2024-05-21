import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/utils/text_styles.dart';

import 'w_bottom_sheet.dart';

void showCupertinoDatePicker(
    BuildContext context,
    Function(DateTime) datePicked,
    DateTime initialDate,
    {DateTime? minDate, // Add minDate as an optional parameter
      DateTime? maxDate, // Add maxDate as an optional parameter
    }) {
  FocusScope.of(context).unfocus();
  showModalBottomSheet(
    useRootNavigator: true,
    elevation: 0,
    backgroundColor: Colors.transparent,
    isScrollControlled: false,
    context: context,
    builder: (_) => WBottomSheet(
      contentPadding: const EdgeInsets.all(20),
      children: [
        DateTimePickerWidget(
          initDateTime: initialDate,
          minDateTime: minDate ?? DateTime.now(), // Set the minDateTime property
          maxDateTime: DateTime(2030), // Optionally set maxDateTime property
          dateFormat: 'dd MM yyyy',
          pickerTheme: DateTimePickerTheme(
              confirmTextStyle: blueStyle(context)
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
              backgroundColor: white,
              itemTextStyle: darkStyle(context).copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
          onCancel: () {},
          onConfirm: (value, _) {
            datePicked(value);
          },
        ),
      ],
    ),
  );
}

