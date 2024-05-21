import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_app/assets/constants/app_icons.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/globals/widgets/w_scale.dart';
import 'package:service_app/modules/notification/domain/entity.dart';
import 'package:service_app/modules/notification/presentation/widgets/service_chip.dart';
import 'package:service_app/utils/text_styles.dart';

class ServiceSelectionScreen extends StatefulWidget {
  final ChipEntity? initialSelectedChip;

  const ServiceSelectionScreen({this.initialSelectedChip, super.key});

  @override
  State<ServiceSelectionScreen> createState() => _ServiceSelectionScreenState();
}

class _ServiceSelectionScreenState extends State<ServiceSelectionScreen> {
  late List<ChipEntity> chips;

  @override
  void initState() {
    super.initState();
    chips = [
      ChipEntity(image: AppIcons.rateUs, title: 'Netflix'),
      ChipEntity(image: AppIcons.support, title: 'Spotify'),
      ChipEntity(image: AppIcons.share, title: 'Share'),
      ChipEntity(image: AppIcons.notification, title: 'Apple'),
      ChipEntity(image: AppIcons.calendar, title: 'Calendar'),
    ];
    if (widget.initialSelectedChip != null) {
      final index =
      chips.indexWhere((chip) => chip.title == widget.initialSelectedChip!.title);
      if (index != -1) {
        chips[index].isClicked = true;
      }
    }
  }

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
          itemCount: chips.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 0.3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemBuilder: (context, index) => ServiceChip(
                isClicked: chips[index].isClicked,
                onTap: () {
                  setState(() {
                    for (int i = 0; i < chips.length; i++) {
                      chips[i].isClicked = false;
                    }
                    chips[index].isClicked = true;
                  });
                },
                entity: chips[index],
              )),
      bottomNavigationBar: WButton(
        isDisabled: chips.every((element) => element.isClicked == false),
        onTap: () {
          final selectedChip = chips.firstWhere((chip) => chip.isClicked);
          Navigator.pop(context, selectedChip);
        },
        margin: EdgeInsets.fromLTRB(
            16, 0, 16, MediaQuery.paddingOf(context).bottom + 16),
        text: 'Select',
      ),
    );
  }
}
