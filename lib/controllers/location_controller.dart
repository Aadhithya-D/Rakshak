import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shake/shake.dart';
import 'package:telephony/telephony.dart';

import '../services/background_service.dart';

class LocationController extends GetxController {
  var currentPosition = LatLng(0, 0).obs;
  @override
  void onInit() {
    // TODO: implement onInit
    getPermissions();
    // final Telephony telephony = Telephony.instance;
    // List<String> recipients = ["7010054699"];
    // ShakeDetector detector = ShakeDetector.autoStart(
    //     minimumShakeCount: 3,
    //     onPhoneShake: () {
    //       // Do stuff on phone shake
    //       // await AudioPlayer().clearAssetCache();
    //       // wrongInfo("Message sent successfully");
    //       telephony.sendSms(
    //           to: recipients[0],
    //           message:
    //               "Help Help Help!!, My Location is : http://www.google.com/maps/place/${currentPosition.value.latitude},${currentPosition.value.longitude}");
    //       // await player.play(AssetSource("siren.mp3"));
    //     });
    super.onInit();
  }

  getPermissions() async {
    await Permission.notification.isDenied.then(((value) {
      if (value) {
        Permission.notification.request();
      }
    }));
    await initializeService();
    FlutterBackgroundService().invoke('setAsBackground');
  }
}
