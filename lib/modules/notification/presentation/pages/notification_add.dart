import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/assets/constants/app_icons.dart';
import 'package:service_app/globals/widgets/default_text_fileld.dart';
import 'package:service_app/globals/widgets/keyboard_dismisser.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/globals/widgets/w_checkbox.dart';
import 'package:service_app/globals/widgets/w_scale.dart';
import 'package:service_app/modules/navigation/presentation/navigator.dart';
import 'package:service_app/modules/notification/presentation/pages/service_selection.dart';
import 'package:service_app/utils/text_styles.dart';

class NotificationAddScreen extends StatefulWidget {
  const NotificationAddScreen({Key? key}) : super(key: key);

  @override
  State<NotificationAddScreen> createState() => _NotificationAddScreenState();
}

class _NotificationAddScreenState extends State<NotificationAddScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          leadingWidth: 100,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: WScaleAnimation(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.back,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Back',
                    style: blueStyle(context)
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          title: Text(
            'Add service',
            style: darkStyle(context)
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              WButton(
                onTap: () => Navigator.push(context, fade(page: const ServiceSelectionScreen())),
                color: whiteSmoke,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select service',
                      style: darkStyle(context)
                          .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: grey,
                      size: 20,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              DefaultTextField(
                onChanged: (value) {},
                title: 'Payment notification date',
                controller: TextEditingController(),
              ), const SizedBox(
                height: 16,
              ),
              DefaultTextField(
                onChanged: (value) {},
                title: 'Sum of payment',
                controller: TextEditingController(),
              ),
              const SizedBox(height: 16,),
              WScaleAnimation(
                onTap: () {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                child: Row(
                  children: [
                    WCheckBox(
                      isChecked: isChecked,
                      checkBoxColor: primaryColor,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Remind every month',
                      style: darkStyle(context)
                          .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar:  WButton(onTap: () {}, margin: EdgeInsets.fromLTRB(16, 0, 16, MediaQuery.paddingOf(context).bottom + 16), text: 'Add',),
      ),
    );
  }
}
