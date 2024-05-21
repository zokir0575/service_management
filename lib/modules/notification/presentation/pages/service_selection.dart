import 'package:flutter/material.dart';
 import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_app/assets/constants/app_icons.dart';
import 'package:service_app/globals/source/database_helper.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/globals/widgets/w_scale.dart';
import 'package:service_app/modules/home/data/model/service_model.dart';
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
  int selectedChipIndex = -1;
  ServiceModel? selectedService;
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
      body: FutureBuilder(
          future: DatabaseHelper.getServices(), builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.hasData) {
          if (snapshot.data != null && snapshot.data!.isNotEmpty) {
            return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 0.3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8),
                itemBuilder: (context, index) {
                  bool isClicked = index == selectedChipIndex;
                  return ServiceChip(
                      isClicked: isClicked,
                      onTap: () {
                        setState(() {
                          selectedChipIndex = index;
                          selectedService = snapshot.data![index];
                        });
                      },
                      entity: ChipEntity(image: snapshot.data![index].image,
                          title: snapshot.data![index].name),
                    );
                });
          } else {
            return Center(
              child: Text(
                'Services not found',
                style: darkStyle(context).copyWith(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
            );
          }
        } else {
          return Center(
            child: Text(
              'Services not found',
              style: darkStyle(context)
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          );
        }
      }),
      bottomNavigationBar: WButton(
        isDisabled: selectedChipIndex == -1,
        onTap: () {
          if (selectedChipIndex != -1) {
            final selectedChip = ChipEntity(
              image: selectedService!.image,
              title: selectedService!.name,
            );
            Navigator.pop(context, selectedChip);
          }
        },
        margin: EdgeInsets.fromLTRB(
            16, 0, 16, MediaQuery
            .paddingOf(context)
            .bottom + 16),
        text: 'Select',
      ),
    );
  }
}