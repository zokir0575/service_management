import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_app/assets/constants/app_icons.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/globals/widgets/w_scale.dart';
import 'package:service_app/modules/notification/presentation/widgets/service_chip.dart';
import 'package:service_app/utils/text_styles.dart';

class ServiceSelectionScreen extends StatefulWidget {
  const ServiceSelectionScreen({super.key});

  @override
  State<ServiceSelectionScreen> createState() => _ServiceSelectionScreenState();
}

class _ServiceSelectionScreenState extends State<ServiceSelectionScreen> {
  List<bool> chipStates = List.generate(5, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Select service',
          style: darkStyle(context)
              .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: chipStates.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 0.3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemBuilder: (context, index) => ServiceChip(
                isClicked: chipStates[index],
                onTap: () {
                  setState(() {
                    chipStates = List.generate(chipStates.length, (_) => false);
                    chipStates[index] = true;
                  });
                },
              )),
      bottomNavigationBar:  WButton(onTap: () => Navigator.pop(context), margin: EdgeInsets.fromLTRB(16, 0, 16, MediaQuery.paddingOf(context).bottom + 16), text: 'Select',),
    );
  }
}
