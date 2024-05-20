import 'package:flutter/cupertino.dart';
import 'package:service_app/modules/calendar/presentation/pages/calendar_screen.dart';
import 'package:service_app/modules/home/presentation/pages/home_screen.dart';
import 'package:service_app/modules/notification/presentation/pages/notification_screen.dart';
import 'package:service_app/modules/settings/presentation/pages/settings_screen.dart';

import 'home.dart';

class TabNavigatorRoutes {
  static const String root = '/';
}

class TabNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final NavItemEnum tabItem;

  const TabNavigator(
      {required this.tabItem, required this.navigatorKey, super.key});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator>
    with AutomaticKeepAliveClientMixin {
  Map<String, WidgetBuilder> _routeBuilders(
      {required BuildContext context, required RouteSettings routeSettings}) {
    switch (widget.tabItem) {
      case NavItemEnum.home:
        return {
          TabNavigatorRoutes.root: (context) => const HomeScreen(),
        };

      case NavItemEnum.calendar:
        return {
          TabNavigatorRoutes.root: (context) => const CalendarScreen(),
        };
      case NavItemEnum.notification:
        return {
          TabNavigatorRoutes.root: (context) => const NotificationScreen(),
        };
      case NavItemEnum.setting:
        return {
          TabNavigatorRoutes.root: (context) => const SettingsScreen(),
        };

      default:
        return {
          TabNavigatorRoutes.root: (context) => Container(),
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
      key: widget.navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        final routeBuilders =
            _routeBuilders(context: context, routeSettings: routeSettings);
        return CupertinoPageRoute(
          builder: (context) => routeBuilders.containsKey(routeSettings.name)
              ? routeBuilders[routeSettings.name]!(context)
              : Container(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

PageRouteBuilder fade({required Widget page, RouteSettings? settings}) {
  return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
            opacity: CurvedAnimation(
              curve: const Interval(0, 1, curve: Curves.linear),
              parent: animation,
            ),
            child: child,
          ),
      settings: settings,
      pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
          page);
}
