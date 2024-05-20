import 'package:flutter/material.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/globals/widgets/w_scale.dart';
import 'package:service_app/modules/navigation/presentation/navigator.dart';
import 'package:service_app/modules/notification/presentation/pages/notification_add.dart';
import 'package:service_app/modules/notification/presentation/widgets/notification_item.dart';
import 'package:service_app/utils/text_styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            16, MediaQuery.paddingOf(context).top + 16, 16, 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notifications',
                  style: darkStyle(context)
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 32),
                ),
                WScaleAnimation(
                  onTap: () => Navigator.of(context, rootNavigator: true)
                      .push(fade(page: const NotificationAddScreen())),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add,
                        color: primaryColor,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Add',
                        style: blueStyle(context).copyWith(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isEmpty) ...{
              const Spacer(),
              Text(
                'You do not have active subscriptions to services',
                style: greyStyle(context)
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Spacer(),
            } else ...{
              Expanded(child: ListView.builder(itemBuilder: (context, index) => NotificationItem(), itemCount: 4,))
            }
          ],
        ),
      ),
    );
  }
}
