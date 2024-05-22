
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/globals/source/database_helper.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/modules/home/data/model/service_model.dart';
import 'package:service_app/modules/home/presentation/bloc/page_index/page_index_bloc.dart';
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
  late PageIndexBloc pageIndexBloc;

  @override
  void initState() {
    pageIndexBloc = PageIndexBloc();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
    value: pageIndexBloc,
  child: Scaffold(
      body: BlocBuilder<PageIndexBloc, PageIndexState>(
  builder: (context, state) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.paddingOf(context).top + 12, bottom: 24),
                child: Column(
                  children: [

                    FutureBuilder<double?>(future: DatabaseHelper.getSumOfPrices(), builder: (context, snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else if (snapshot.hasData) {
                        if (snapshot.data != null && snapshot.data != 0) {
                          return  Text(
                            '-\$${snapshot.data}',
                            style: darkStyle(context)
                                .copyWith(fontSize: 44, fontWeight: FontWeight.w600),
                          );
                        } else {
                          return Text(
                            '-\$0',
                            style: darkStyle(context)
                                .copyWith(fontSize: 44, fontWeight: FontWeight.w600),
                          );
                        }
                      } else {
                        return Text(
                          '-\$0',
                          style: darkStyle(context)
                              .copyWith(fontSize: 44, fontWeight: FontWeight.w600),
                        );
                      }
                    }),
                    const SizedBox(height: 8),
                    Text(
                      'Monthly',
                      style: greyStyle(context)
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    WButton(
                      onTap: () => Navigator.of(context, rootNavigator: true)
                          .push(fade(page: const AddServiceScreen())),
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
              ),
            ),
            SliverAppBar(
              pinned: true,
              surfaceTintColor: Colors.transparent,
              flexibleSpace: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.05),
                          offset: const Offset(0, -4),
                          blurRadius: 41.3,
                          spreadRadius: 0)
                    ]),
                padding: EdgeInsets.fromLTRB(
                    16, MediaQuery.paddingOf(context).top + 16, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: WButton(
                        onTap: () {
                          pageController.jumpToPage(0);
                        },
                        color:
                            state.pageIndex == 0 ? lightPrimaryColor : lightPrimary2,
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
                        color:

                        state.pageIndex == 1 ? lightPrimaryColor : lightPrimary2,
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
        body: PageView(
          controller: pageController,
          onPageChanged: (int index) {
            pageIndexBloc.add(PageChanged(index: index));
          },
          children: [
            FutureBuilder<List<ServiceModel>?>(
              future: DatabaseHelper.getServices(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(

                    ),
                  ));
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.hasData) {
                  if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ServiceItem(
                          onLongPress: (){
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Are you sure you want to delete this note?'),
                                    actions: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                                red)),
                                        onPressed: () async {
                                          await DatabaseHelper.deleteService(
                                              snapshot.data![index]);
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child:   Text('Yes', style: whiteStyle(context).copyWith(fontSize: 14, fontWeight: FontWeight.w400),),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child:   Text('No', style: darkStyle(context).copyWith(fontSize: 14, fontWeight: FontWeight.w400),),
                                      ),
                                    ],
                                  );
                                });
                          },
                          model: snapshot.data![index],
                        );
                      },
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Add your first service!',
                        style: darkStyle(context).copyWith(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: Text(
                      'Add your first service!',
                      style: darkStyle(context)
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  );
                }
              },
            ),
            FutureBuilder<List<ServiceModel>?>(
                future: DatabaseHelper.getServices(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(

                      ),
                    ));
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      ListView.builder(
                        itemBuilder: (context, index) => ServiceItem(
                          model: snapshot.data![index], onLongPress: () { showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                    'Are you sure you want to delete this note?'),
                                actions: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            Colors.red)),
                                    onPressed: () async {
                                      await DatabaseHelper.deleteService(
                                          snapshot.data![index]);
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: const Text('Yes'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('No'),
                                  ),
                                ],
                              );
                            }); },
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: snapshot.data!.length,
                      );
                    } else {
                      return Center(
                        child: Text(
                          'Your services not expired yet',
                          style: darkStyle(context).copyWith(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      );
                    }
                  }
                  return Center(
                    child: Text(
                      'Your services not expired yet',
                      style: darkStyle(context)
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  );
                }),
          ],
        ),
      );
  },
),
    ),
);
  }
}
