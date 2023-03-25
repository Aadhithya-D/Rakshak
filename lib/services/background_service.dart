

import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shake/shake.dart';
import 'package:telephony/telephony.dart';

import '../controllers/location_controller.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(
          autoStart: true,

          onBackground: onIosBackground,
          onForeground: onStart
      ),
      androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          isForegroundMode: true,autoStart: true
      )
  );
}
// void wrongInfo(String error) {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(
//             "Rakshak",
//             style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
//           ),
//           content: Text(
//             error,
//             style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
//           ),
//           backgroundColor: Theme.of(context).colorScheme.background,
//           titlePadding: const EdgeInsets.all(20),
//           actions: [
//             TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("Ok",
//                     style: TextStyle(
//                         color: Theme.of(context).colorScheme.tertiary)))
//           ],
//         );
//       });
// }

@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();

  if(service is AndroidServiceInstance){
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if(service is AndroidServiceInstance){
      if(await service.isForegroundService()){
        service.setForegroundNotificationInfo(
            title: "Raksha",
            content: "You are protected"
        );
      }
    }
    // final Telephony telephony = Telephony.instance;
    // final LocationController locationController = Get.put(LocationController());
    // ShakeDetector detector = ShakeDetector.autoStart(
    //     minimumShakeCount: 3,
    //     onPhoneShake: () async {
    //       // Do stuff on phone shake
    //       // await AudioPlayer().clearAssetCache();
    //       // wrongInfo("Message sent successfully");
    //       telephony.sendSms(
    //           to: "7010054699",
    //           message:
    //           "Help Help Help!!, My Location is : http://www.google.com/maps/place/${locationController.currentPosition.value.latitude},${locationController.currentPosition.value.longitude}");
    //       // await player.play(AssetSource("siren.mp3"));
    //     });
    print("Background is successful");
    service.invoke('update');

  });
}

@pragma('vm:entry-point')
FutureOr<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}