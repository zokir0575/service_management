import 'package:flutter/material.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/modules/navigation/presentation/home.dart';
import 'package:service_app/modules/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:service_app/utils/storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StorageRepository.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(StorageRepository.getBool('registered'));
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: white),
      debugShowCheckedModeBanner: false,
      home: StorageRepository.getBool('registered')
          ? const NavigationScreen()
          : const OnBoardingScreen(),
    );
  }
}
