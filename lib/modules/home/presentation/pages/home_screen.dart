import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/modules/home/presentation/pages/add_service_screen.dart';
import 'package:service_app/modules/home/presentation/widgets/service_item.dart';
import 'package:service_app/modules/navigation/presentation/navigator.dart';
import 'package:service_app/utils/text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(child:       Padding(
              padding:
              EdgeInsets.only(top: MediaQuery.paddingOf(context).top + 12, bottom: 24),
              child: Column(
                children: [
                  Text(
                    '- \$21,65',
                    style: darkStyle(context)
                        .copyWith(fontSize: 44, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Monthly',
                    style: greyStyle(context)
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  WButton(
                    onTap: () => Navigator.of(context, rootNavigator: true).push( fade(page: const AddServiceScreen())),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          color: white,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Add service',
                          style: whiteStyle(context).copyWith(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),),
            SliverAppBar(
              pinned: true,
              surfaceTintColor: Colors.transparent
              ,
               flexibleSpace: Container(
                 width: double.infinity,
                 decoration:   BoxDecoration(
                   color: white,
                   borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black.withOpacity(.05),
                       offset: Offset(0, -4),
                       blurRadius: 41.3,
                       spreadRadius: 0
                     )
                   ]
                 ),
                padding: EdgeInsets.fromLTRB(16, MediaQuery.paddingOf(context).top + 16, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: WButton(
                        onTap: () {
                          pageController.jumpToPage(0);
                        },
                        color: pageIndex == 0 ? lightPrimaryColor : lightPrimary2,
                        text: 'Active',
                        textStyle: blueStyle(context).copyWith(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: WButton(
                        onTap: () => pageController.jumpToPage(1),
                        textStyle: blueStyle(context).copyWith(
                            fontWeight: FontWeight.w600, fontSize: 16),
                        color: pageIndex == 1 ? lightPrimaryColor : lightPrimary2,
                        text: 'Inactive',
                      ),
                    ),
                  ],
                ),
              ),
              toolbarHeight: 80,
            ),
          ];
        },
        body:  PageView(
          controller: pageController,
          onPageChanged: (int index) {
            setState(() {
              pageIndex = index;
            });
          },
          children: [
            ListView.builder(itemBuilder: (context, index) => ServiceItem(),padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: 10,),
            ListView.builder(itemBuilder: (context, index) => ServiceItem(),padding: const EdgeInsets.symmetric(horizontal: 16),  itemCount: 2,),
           ],
        ),

      ),
    );
  }
}
