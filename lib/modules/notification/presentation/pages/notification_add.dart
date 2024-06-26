import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/assets/constants/app_icons.dart';
import 'package:service_app/globals/bloc/date_picker/date_picker_bloc.dart';
import 'package:service_app/globals/bloc/date_picker/date_picker_event.dart';
import 'package:service_app/globals/bloc/date_picker/date_picker_state.dart';
import 'package:service_app/globals/source/database_helper.dart';
import 'package:service_app/globals/widgets/cupertino_datepicker.dart';
import 'package:service_app/globals/widgets/default_text_fileld.dart';
import 'package:service_app/globals/widgets/keyboard_dismisser.dart';
import 'package:service_app/globals/widgets/snackbar.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/globals/widgets/w_checkbox.dart';
import 'package:service_app/globals/widgets/w_scale.dart';
import 'package:service_app/modules/navigation/presentation/navigator.dart';
import 'package:service_app/modules/notification/data/model/notification_service.dart';
import 'package:service_app/modules/notification/domain/entity.dart';
import 'package:service_app/modules/notification/presentation/pages/service_selection.dart';
import 'package:service_app/utils/storage.dart';
import 'package:service_app/utils/text_styles.dart';

class NotificationAddScreen extends StatefulWidget {
  const NotificationAddScreen({Key? key}) : super(key: key);

  @override
  State<NotificationAddScreen> createState() => _NotificationAddScreenState();
}

class _NotificationAddScreenState extends State<NotificationAddScreen> {
  bool isChecked = false;
  late TextEditingController dateController;
  late TextEditingController priceController;
  late DatePickerBloc datePickerBloc;
  ChipEntity? selectedChip;
  bool showNotification = false;

  @override
  void initState() {
    showNotification = StorageRepository.getBool('showNotification');

    datePickerBloc = DatePickerBloc();
    dateController = TextEditingController();
    priceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void showNotificationAction() async {

    setState(() {
      StorageRepository.putBool(
        key: "showNotification",
        value: !showNotification,
      );
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
    return KeyboardDismisser(
      child: BlocProvider.value(
        value: datePickerBloc,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: white,
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                WButton(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      fade(
                        page: ServiceSelectionScreen(
                          initialSelectedChip: selectedChip,
                        ),
                      ),
                    );
                    if (result != null && result is ChipEntity) {
                      setState(() {
                        selectedChip = result;
                      });
                    }
                  },
                  color: whiteSmoke,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      if (selectedChip != null) ...{
                        Image.file(
                          File(selectedChip!.image),
                          height: 32,
                          width: 32,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                      },
                      Text(
                        selectedChip?.title ?? 'Select service',
                        style: darkStyle(context).copyWith(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: grey,
                        size: 20,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<DatePickerBloc, DatePickerState>(
                  builder: (context, state) {
                    return DefaultTextField(
                      readOnly: true,
                      onTap: selectedChip == null
                          ? () {
                              showInfoSnackBar(context,
                                  text: 'First select service');
                            }
                          : () {
                              showCupertinoDatePicker(
                                context,
                                (date) {
                                  String formattedDate =
                                      Jiffy.parseFromDateTime(date)
                                          .format(pattern: 'dd.MM.yy');
                                  dateController.text = formattedDate;
                                  context.read<DatePickerBloc>().add(
                                        PickedEndDate(date: formattedDate),
                                      );
                                },
                                minDate: DateFormat('dd.MM.yyyy')
                                    .parse(selectedChip?.date ?? ''),
                                DateFormat('dd.MM.yyyy')
                                    .parse(selectedChip?.date ?? ''),
                              );
                            },
                      onChanged: (value) {
                        setState(() {});
                      },
                      hintText: 'dd.mm.yy',
                      keyboardType: TextInputType.number,
                      title: 'End of subscription',
                      controller: dateController,
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                DefaultTextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  keyboardType: TextInputType.number,
                  title: 'Sum of payment',
                  prefix: Padding(
                    padding: const EdgeInsets.only(left: 12.0, bottom: 2),
                    child: Text(
                      '\$ ',
                      style: darkStyle(context)
                          .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ),
                  controller: priceController,
                ),
                const SizedBox(
                  height: 16,
                ),
                WScaleAnimation(
                  onTap: !StorageRepository.getBool('showNotification')
                      ? () {
                          print('a');
                          showNotificationAction();
                        }
                      : () {
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
                        'Remind every month',
                        style: darkStyle(context).copyWith(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: WButton(
            onTap: () async {
              final price = priceController.text;
              final date = dateController.text;

              final NotificationServiceModel model = NotificationServiceModel(
                image: selectedChip!.image,
                price: price,
                isSwitched: isChecked,
                id: Random().nextInt(100),
                date: date,
              );
              await DatabaseHelper.addNotificationService(model);
              Navigator.pop(context, model);
            },
            isDisabled: selectedChip == null ||
                priceController.text.isEmpty ||
                dateController.text.isEmpty,
            margin: EdgeInsets.fromLTRB(
                16, 0, 16, MediaQuery.paddingOf(context).bottom + 16),
            text: 'Add',
          ),
        ),
      ),
    );
  }
}
