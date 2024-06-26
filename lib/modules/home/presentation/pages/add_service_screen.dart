import 'dart:io';
import 'dart:math';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/globals/widgets/w_checkbox.dart';
import 'package:service_app/globals/widgets/w_scale.dart';
import 'package:service_app/modules/home/data/model/service_model.dart';
import 'package:service_app/modules/home/presentation/bloc/image_picker/image_picker_bloc.dart';
import 'package:service_app/modules/navigation/presentation/home.dart';
import 'package:service_app/modules/navigation/presentation/navigator.dart';
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
  late ImagePickerBloc imagePickerBloc;
  late DatePickerBloc datePickerBloc;
  String imagePath = '';
  DateTime? selectedStartDate;

  @override
  void initState() {
    datePickerBloc = DatePickerBloc();
    imagePickerBloc = ImagePickerBloc();
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: imagePickerBloc,
          ),
          BlocProvider.value(value: datePickerBloc),
        ],
        child: Scaffold(
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
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                WScaleAnimation(
                    onTap: () {
                      showAdaptiveActionSheet(
                        context: context,
                        bottomSheetColor: white,
                        androidBorderRadius: 30,
                        actions: <BottomSheetAction>[
                          BottomSheetAction(
                              title: const Text(
                                'Choose from gallery',
                                style: TextStyle(
                                  color: Color(0xFF007AFF),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onPressed: (context) {
                                imagePickerBloc.add(OpenGallery());
                                Navigator.pop(context);
                              }),
                          BottomSheetAction(
                              title: const Text(
                                'Open camera',
                                style: TextStyle(
                                  color: Color(0xFF007AFF),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onPressed: (context) {
                                imagePickerBloc.add(OpenCamera());
                                Navigator.pop(context);
                              }),
                        ],
                        cancelAction: CancelAction(
                          title: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Color(0xFF007AFF),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onPressed: (context) => Navigator.pop(context),
                        ), // onPressed parameter is optional by default will dismiss the ActionSheet
                      );
                    },
                    child: ValueListenableBuilder(
                        valueListenable: imagePickerBloc.pickedImageFile,
                        builder: (context, String? value, Widget? child) {
                          imagePath = value ?? '';

                          return imageType(
                              pickedImage: value ?? '', context: context);
                        })),
                const SizedBox(
                  height: 24,
                ),
                DefaultTextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  keyboardType: TextInputType.text,
                  title: 'Name of service',
                  hintText: 'Write down your name...',
                  controller: nameController,
                ),
                const SizedBox(
                  height: 16,
                ),
                DefaultTextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {});
                  },
                  prefix: Padding(
                    padding: const EdgeInsets.only(left: 12.0, bottom: 2),
                    child: Text(
                      '\$ ',
                      style: darkStyle(context)
                          .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ),
                  maxLength: 12,
                  title: 'Price (monthly)',
                  controller: priceController,
                ),
                const SizedBox(
                  height: 16,
                ),
                DefaultTextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  keyboardType: TextInputType.text,
                  title: 'URL',
                  controller: urlController,
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<DatePickerBloc, DatePickerState>(
                  builder: (context, state) {
                    return DefaultTextField(
                      readOnly: true,
                      onTap: () {
                        DateTime getOriginalDate(String date) {
                          if (date.isNotEmpty) {
                            return DateTime.parse(date.replaceAllMapped(
                              RegExp(r'(\d{2}).(\d{2}).(\d{4})'),
                              (match) => '${match[3]}-${match[2]}-${match[1]}',
                            ));
                          } else {
                            return DateTime.now();
                          }
                        }

                        DateTime originalDate =
                            getOriginalDate(state.startDate);
                        String formattedDateString =
                            '${originalDate.year}-${originalDate.month.toString().padLeft(2, '0')}-${originalDate.day.toString().padLeft(2, '0')}';

                        showCupertinoDatePicker(
                          context,
                          (date) {
                            String formattedDate = Jiffy.parseFromDateTime(date)
                                .format(pattern: 'dd.MM.yy');
                            startController.text = formattedDate;
                            selectedStartDate = date;
                            context.read<DatePickerBloc>().add(
                                  PickedStartDate(date: formattedDate),
                                );
                          },
                          DateTime.parse(formattedDateString),
                        );
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                      hintText: 'dd.mm.yy',
                      keyboardType: TextInputType.number,
                      title: 'Start of subscription',
                      controller: startController,
                    );
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<DatePickerBloc, DatePickerState>(
                  builder: (context, state) {
                    return DefaultTextField(
                      readOnly: true,
                      onTap: startController.text.isEmpty
                          ? () {}
                          : () {
                              DateTime getOriginalDate(String date) {
                                if (date.isNotEmpty) {
                                  return DateTime.parse(date.replaceAllMapped(
                                    RegExp(r'(\d{2}).(\d{2}).(\d{4})'),
                                    (match) =>
                                        '${match[3]}-${match[2]}-${match[1]}',
                                  ));
                                } else {
                                  return DateTime.now();
                                }
                              }

                              DateTime originalDate =
                                  getOriginalDate(state.endDate);
                              String formattedDateString =
                                  '${originalDate.year}-${originalDate.month.toString().padLeft(2, '0')}-${originalDate.day.toString().padLeft(2, '0')}';
                              DateTime newDate = DateTime(
                                      selectedStartDate!.year,
                                      selectedStartDate!.month + 1,
                                      selectedStartDate!.day)
                                  .add(const Duration(days: 1));

                              showCupertinoDatePicker(
                                context,
                                (date) {
                                  String formattedDate =
                                      Jiffy.parseFromDateTime(date)
                                          .format(pattern: 'dd.MM.yy');
                                  endController.text = formattedDate;
                                  context.read<DatePickerBloc>().add(
                                        PickedEndDate(date: formattedDate),
                                      );
                                },
                                DateTime.parse(formattedDateString),
                                minDate: newDate,
                              );
                            },
                      onChanged: (value) {
                        setState(() {});
                      },
                      hintText: 'dd.mm.yy',
                      keyboardType: TextInputType.number,
                      title: 'End of subscription',
                      controller: endController,
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
                  keyboardType: TextInputType.text,
                  hintText: 'Write your note...',
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
            isDisabled: imagePath.isEmpty ||
                nameController.text.isEmpty ||
                priceController.text.isEmpty ||
                urlController.text.isEmpty ||
                startController.text.isEmpty ||
                endController.text.isEmpty ||
                noteController.text.isEmpty,
            onTap: () async {
              final name = nameController.text;
              final price = priceController.text;
              final url = urlController.text;
              final start = startController.text;
              final end = endController.text;
              final note = noteController.text;
              final ServiceModel model = ServiceModel(
                  end: end,
                  name: name,
                  price: price,
                  url: url,
                  image: imagePath!,
                  id: Random().nextInt(100),
                  start: start,
                  note: note);
              await DatabaseHelper.addService(model);
              Navigator.pushAndRemoveUntil(context,
                  fade(page: const NavigationScreen()), (route) => false);
            },
            text: 'Add',
            margin: EdgeInsets.fromLTRB(
                16, 0, 16, MediaQuery.paddingOf(context).bottom + 12),
          ),
        ),
      ),
    );
  }
}

Widget imageType({required String pickedImage, required BuildContext context}) {
  print('pickedImage: $pickedImage');
  if (pickedImage.isEmpty) {
    return ClipRRect(
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
              color: lightPrimary2, borderRadius: BorderRadius.circular(12)),
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
                style: blueStyle(context)
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  } else if (pickedImage.isNotEmpty) {
    return Center(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.file(
        File(pickedImage),
        height: 120,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    ));
  }
  return const SizedBox();
}
