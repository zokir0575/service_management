import 'package:flutter/material.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/assets/constants/app_icons.dart';
import 'package:service_app/globals/source/database_helper.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/globals/widgets/w_cupertino_switch.dart';
import 'package:service_app/modules/navigation/presentation/navigator.dart';
import 'package:service_app/modules/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:service_app/modules/settings/domain/entity/button.dart';
import 'package:service_app/modules/settings/presentation/pages/support_screen.dart';
import 'package:service_app/modules/settings/presentation/widgets/profile_buttons.dart';
import 'package:service_app/utils/storage.dart';
import 'package:service_app/utils/text_styles.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late List<ButtonEntity> buttons;

  @override
  void initState() {
    buttons = [
      ButtonEntity(
          title: 'Support',
          onTap: () => Navigator.of(context, rootNavigator: true)
              .push(fade(page: const SupportScreen())),
          icon: AppIcons.support),
      ButtonEntity(title: 'Share app', onTap: () {}, icon: AppIcons.share),
      ButtonEntity(title: 'Rate us', onTap: () {}, icon: AppIcons.rateUs),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.fromLTRB(
          16, MediaQuery.paddingOf(context).top + 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: darkStyle(context)
                .copyWith(fontSize: 32, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: whiteSmoke, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notifications',
                  style: darkStyle(context)
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                WCupertinoSwitch(
                  onChange: (value) {},
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          ...List.generate(
            3,
            (index) => ProfileButton(
              buttonEntity: buttons[index],
            ),
          ),
          const Spacer(),
          WButton(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  backgroundColor: white,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Are you sure you want to delete your account?',
                            textAlign: TextAlign.center,
                            style: darkStyle(context).copyWith(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Deleted data cannot be returned',
                            style: greyStyle(context).copyWith(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          WButton(
                            onTap: ()async  {
                              StorageRepository.putBool(key: 'registered', value: false);
                              await DatabaseHelper.deleteAllServices();
                              Navigator.pushAndRemoveUntil(context, fade( page: const OnBoardingScreen()), (route) => false);
                            },
                            color: lightRed,
                            text: 'Delete',
                            textStyle: darkStyle(context).copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: red),
                          )
                        ],
                      ),
                    );
                  });
            },
            color: lightRed,
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Text(
                  'Delete account',
                  style: darkStyle(context).copyWith(
                      fontSize: 16, fontWeight: FontWeight.w600, color: red),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
