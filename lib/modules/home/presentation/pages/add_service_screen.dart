import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/assets/constants/app_icons.dart';
import 'package:service_app/globals/widgets/default_text_fileld.dart';
import 'package:service_app/globals/widgets/keyboard_dismisser.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/globals/widgets/w_checkbox.dart';
import 'package:service_app/globals/widgets/w_scale.dart';
import 'package:service_app/utils/text_styles.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  bool isChecked = false;
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController urlController;
  late TextEditingController startController;
  late TextEditingController endController;
  late TextEditingController noteController;

  @override
  void initState() {
    nameController = TextEditingController();
    priceController = TextEditingController();
    urlController = TextEditingController();
    startController = TextEditingController();
    endController = TextEditingController();
    noteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    urlController.dispose();
    startController.dispose();
    endController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
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
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              WScaleAnimation(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: DottedBorder(
                    radius: const Radius.circular(12),
                    dashPattern: const [8, 4],
                    strokeWidth: 1,
                    color: primaryColor,
                    padding: const EdgeInsets.all(6),
                    borderType: BorderType.RRect,
                    borderPadding: const EdgeInsets.all(6),
                    child: Container(
                      height: 110,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: lightPrimary2,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add,
                            color: primaryColor,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Add photo',
                            style: blueStyle(context).copyWith(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              DefaultTextField(
                onChanged: (value) {},
                title: 'Name of service',
                controller: nameController,
              ),
              const SizedBox(
                height: 16,
              ),
              DefaultTextField(
                onChanged: (value) {},
                title: 'Price (monthly)',
                controller: priceController,
              ),
              const SizedBox(
                height: 16,
              ),
              DefaultTextField(
                onChanged: (value) {},
                title: 'URL',
                controller: urlController,
              ),
              const SizedBox(
                height: 16,
              ),
              DefaultTextField(
                onChanged: (value) {},
                title: 'Start of subscription',
                controller: startController,
              ),
              const SizedBox(
                height: 16,
              ),
              DefaultTextField(
                onChanged: (value) {},
                title: 'End of subscription',
                controller: endController,
              ),
              const SizedBox(
                height: 16,
              ),
              DefaultTextField(
                onChanged: (value) {},
                title: 'Note',
                height: 100,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                contentPadding: const EdgeInsets.all(12),
                controller: noteController,
              ),
              const SizedBox(
                height: 16,
              ),
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
                      'Send notification with date selection?',
                      style: darkStyle(context)
                          .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: WButton(
          onTap: () {},
          text: 'Add',
          margin: EdgeInsets.fromLTRB(
              16, 0, 16, MediaQuery.paddingOf(context).bottom + 12),
        ),
      ),
    );
  }
}
