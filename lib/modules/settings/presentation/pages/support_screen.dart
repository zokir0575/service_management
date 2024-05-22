import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_app/assets/constants/app_icons.dart';
import 'package:service_app/globals/widgets/default_text_fileld.dart';
import 'package:service_app/globals/widgets/keyboard_dismisser.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/globals/widgets/w_scale.dart';
import 'package:service_app/utils/text_styles.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  late TextEditingController addressController;
  late TextEditingController messageController;

  @override
  void initState() {
    addressController = TextEditingController();
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    addressController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
            'Support',
            style: darkStyle(context)
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        body: Container(
          height: MediaQuery.sizeOf(context).height,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Stack(
            children: [
              Column(
                children: [
                  DefaultTextField(
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    hintText: 'Enter subject of address...',
                    title: 'Subject of address',
                    controller: addressController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DefaultTextField(
                    onChanged: (value) {},
                    title: 'Your message',                    keyboardType: TextInputType.text,

                    hintText: 'Write down your message...',
                    height: 100,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    contentPadding: const EdgeInsets.all(12),
                    controller: messageController,
                  ),
                ],
              ),
              Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 0,
                right: 0,
                child: WButton(
                  isDisabled: addressController.text.isEmpty ||
                      messageController.text.isEmpty,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom + 12),
                  onTap: () => Navigator.pop(context, true),
                  text: 'Send',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
