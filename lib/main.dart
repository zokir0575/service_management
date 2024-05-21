import 'package:flutter/material.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/modules/navigation/presentation/home.dart';
import 'package:service_app/modules/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:service_app/utils/storage.dart';

import 'modules/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StorageRepository.getInstance();

  runApp(  MyApp());
}

class MyApp extends StatelessWidget {
    MyApp({super.key});

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {
    print(StorageRepository.getBool('registered'));
    return MaterialApp(
      navigatorKey: _navigatorKey,
      theme: ThemeData(scaffoldBackgroundColor: white),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) =>MaterialPageRoute(
        builder: (context) => SplashScreen( ),
      ),

    );
  }
}
