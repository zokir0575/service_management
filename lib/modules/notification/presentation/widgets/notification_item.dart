import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/assets/constants/app_icons.dart';
import 'package:service_app/globals/widgets/w_cupertino_switch.dart';
import 'package:service_app/utils/text_styles.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

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
          SvgPicture.asset(AppIcons.support),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '08.08.24',
                style: darkStyle(context)
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                '\$5 monthly • Family + plan',
                style: greyStyle(context).copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12, ),
              ),
            ],
          ),
          const Spacer(),
          WCupertinoSwitch(onChange: (value){}, )
        ],
      ),
    );
  }
}
