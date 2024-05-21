import 'package:flutter/material.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/globals/source/database_helper.dart';
import 'package:service_app/globals/widgets/w_scale.dart';
import 'package:service_app/modules/navigation/presentation/navigator.dart';
import 'package:service_app/modules/notification/data/model/notification_service.dart';
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
  NotificationServiceModel? notificationServiceModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Notifications',
              style: darkStyle(context)
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 32),
            ),
            WScaleAnimation(
              onTap: () async {
                final result = await
                Navigator.of(context, rootNavigator: true)
                    .push(fade(page: const NotificationAddScreen()));

                if (result != null && result is NotificationServiceModel) {
                  setState(() {
                    notificationServiceModel = result;
                  });
                }
              },
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child:             FutureBuilder<List<NotificationServiceModel>?>(
          future: DatabaseHelper.getNotificationServices(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              if (snapshot.data != null && snapshot.data!.isNotEmpty) {

                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return NotificationItem(
                        model: snapshot.data![index],
                      );
                    },

                  ),
                );

              } else {
                return Center(
                  child: Text(
                    'Notifications not found',
                    style: darkStyle(context).copyWith(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                );
              }
            } else {
              return Center(
                child: Text(
                  'Notifications not found',
                  style: darkStyle(context)
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              );
            }
          },
        ),

      ),
    );
  }
}
