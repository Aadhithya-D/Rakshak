import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rakshak/screens/auth_page.dart';
import 'package:rakshak/services/background_service.dart';
import 'package:shake/shake.dart';
import 'package:telephony/telephony.dart';

import 'app_theme.dart';
import 'controllers/location_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Geolocator.requestPermission();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rakshak',
      theme: AppTheme.lightThemeData,
      // darkTheme: AppTheme.darkThemeData,
      // themeMode: isDark?ThemeMode.dark:ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
    );
  }
}
