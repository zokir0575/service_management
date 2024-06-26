import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:in_app_review/in_app_review.dart';
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
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late List<ButtonEntity> buttons;
  bool showNotification = false;
  bool hasDelivered = false;

  @override
  void initState() {
    showNotification = StorageRepository.getBool('showNotification');
    buttons = [
      ButtonEntity(
          title: 'Support',
          onTap: () async {
            final result = await Navigator.of(context, rootNavigator: true)
                .push(fade(page: const SupportScreen()));
            if (result != null && result == true) {
              setState(() {
                hasDelivered = result;
              });
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
                            'Your message has been successfully delivered!',
                            textAlign: TextAlign.center,
                            style: darkStyle(context).copyWith(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Thank you for the opportunity to become better',
                            style: greyStyle(context).copyWith(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          WButton(
                            onTap: () async {
                              Navigator.pop(context);
                            },
                            color: primaryColor,
                            text: 'Ok',
                          )
                        ],
                      ),
                    );
                  });
            }
          },
          icon: AppIcons.support),
      ButtonEntity(
          title: 'Share app',
          onTap: () {
            Share.share('Share us on https://www.google.ru/?hl=ru');
          },
          icon: AppIcons.share),
      ButtonEntity(
          title: 'Rate us',
          onTap: () {
            rateApp();
          },
          icon: AppIcons.rateUs),
    ];
    super.initState();
  }

  void rateApp() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  void showNotificationAction() async {
    StorageRepository.putBool(
      key: "showNotification",
      value: !showNotification,
    );
    setState(() {
      showNotification = !showNotification;
    });
    if (showNotification) {
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
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
                  onTap: !StorageRepository.getBool('showNotification')
                      ? () {
                          print('worked');
                          showNotificationAction();
                        }
                      : null,
                  isSwitched: !StorageRepository.getBool('showNotification')
                      ? false
                      : StorageRepository.getBool('notification_enabled'),
                  onChange: (value) {
                    StorageRepository.putBool(
                        key: 'notification_enabled', value: value);
                  },
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
                            onTap: () async {
                              StorageRepository.putBool(
                                  key: 'notification_enabled', value: false);
                              StorageRepository.putBool(
                                  key: 'registered', value: false);
                              await DatabaseHelper.deleteAllServices();
                              await DatabaseHelper
                                  .deleteAllNotificationServices();
                              Navigator.of(context, rootNavigator: true)
                                  .pushAndRemoveUntil(
                                      fade(page: const OnBoardingScreen()),
                                      (route) => false);
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
