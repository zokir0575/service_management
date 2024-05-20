import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/modules/settings/domain/entity/button.dart';
import 'package:service_app/utils/text_styles.dart';

class ProfileButton extends StatelessWidget {
  final ButtonEntity buttonEntity;

  const ProfileButton({required this.buttonEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return WButton(
      color: whiteSmoke,
       margin: const EdgeInsets.only(bottom: 12),
       onTap: () {
        buttonEntity.onTap();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        child: Row(
          children: [
            SvgPicture.asset(
              buttonEntity.icon,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                buttonEntity.title,
                style: darkStyle(context)
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
