import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/globals/source/database_helper.dart';
import 'package:service_app/globals/widgets/w_cupertino_switch.dart';
import 'package:service_app/modules/notification/data/model/notification_service.dart';
import 'package:service_app/utils/text_styles.dart';

class NotificationItem extends StatefulWidget {
  final NotificationServiceModel model;

  const NotificationItem({required this.model, super.key});

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: whiteSmoke,
      ),
      child: Row(
        children: [
          SvgPicture.asset(widget.model.image),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.model.date,
                style: darkStyle(context)
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                '\$${widget.model.price} monthly • Family + plan',
                style: greyStyle(context).copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const Spacer(),
          WCupertinoSwitch(
            isSwitched: widget.model.isSwitched,
            onChange: (value) async {
              setState(() {
                widget.model.isSwitched = value;
              });
              await DatabaseHelper.updateNotificationService(widget.model);
            },
          )
        ],
      ),
    );
  }
}
