import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/assets/constants/app_icons.dart';
import 'package:service_app/modules/navigation/domain/entities/navbar.dart';
import 'package:service_app/modules/navigation/presentation/widgets/nav_bar_item.dart';

import 'navigator.dart';

enum NavItemEnum { home, calendar, notification, setting }

class NavigationScreen extends StatefulWidget {
  final int? currentIndex;
  const NavigationScreen({this.currentIndex, super.key});

  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => const NavigationScreen());

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late TabController _controller;
  final Map<NavItemEnum, GlobalKey<NavigatorState>> _navigatorKeys = {
    NavItemEnum.home: GlobalKey<NavigatorState>(),
    NavItemEnum.calendar: GlobalKey<NavigatorState>(),
    NavItemEnum.notification: GlobalKey<NavigatorState>(),
    NavItemEnum.setting: GlobalKey<NavigatorState>(),
  };

  List<NavBar> labels = [];
  int _currentIndex = 0;
  DateTime? pauseTime;

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this);

    _controller.addListener(onTabChange);

    super.initState();
  }

  void onTabChange() => setState(() => _currentIndex = _controller.index);

  Widget _buildPageNavigator(NavItemEnum tabItem) => TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      );

  void changePage(int index) {
    setState(() => _currentIndex = index);
    _controller.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    labels = [
      NavBar(id: 0, icon: AppIcons.home, title: 'Home'),
      NavBar(
        id: 1,
        title: 'Calendar',
        icon: AppIcons.calendar,
      ),
      NavBar(
        id: 2,
        title: 'Notifications',
        icon: AppIcons.notification,
      ),
      NavBar(
        id: 3,
        title: 'Settings',
        icon: AppIcons.setting,
      ),
    ];
    return HomeTabControllerProvider(
      controller: _controller,
      child: WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
              !await _navigatorKeys[NavItemEnum.values[_currentIndex]]!
                  .currentState!
                  .maybePop();
          if (isFirstRouteInCurrentTab) {
            if (NavItemEnum.values[_currentIndex] != NavItemEnum.home) {
              changePage(0);
              return false;
            }
          }
          return isFirstRouteInCurrentTab;
        },
        child: AnnotatedRegion(
          value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light),
          child: Scaffold(
            bottomNavigationBar: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 115, sigmaY: 150, tileMode: TileMode.repeated),
                child: Container(
                  height: 68 + MediaQuery.of(context).padding.bottom,
                  decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      BoxShadow(
                        color: whiteSmoke.withOpacity(0.64),
                        blurRadius: 24,
                        offset: const Offset(0, -8),
                      )
                    ],
                  ),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    enableFeedback: true,
                    onTap: (index) {},
                    indicatorColor: Colors.transparent,
                    controller: _controller,
                    labelPadding: EdgeInsets.zero,
                    tabs: List.generate(
                      labels.length,
                      (index) => NavItemWidget(
                        navBar: labels[index],
                        currentIndex: _currentIndex,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            resizeToAvoidBottomInset: true,
            body: TabBarView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildPageNavigator(NavItemEnum.home),
                _buildPageNavigator(NavItemEnum.calendar),
                _buildPageNavigator(NavItemEnum.notification),
                _buildPageNavigator(NavItemEnum.setting),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeTabControllerProvider extends InheritedWidget {
  final TabController controller;

  const HomeTabControllerProvider({
    super.key,
    required super.child,
    required this.controller,
  });

  static HomeTabControllerProvider of(BuildContext context) {
    final HomeTabControllerProvider? result =
        context.dependOnInheritedWidgetOfExactType<HomeTabControllerProvider>();
    assert(result != null, 'No HomeTabControllerProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(HomeTabControllerProvider oldWidget) => false;
}
