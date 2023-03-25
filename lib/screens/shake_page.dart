import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shake/shake.dart';
import 'package:telephony/telephony.dart';

import '../controllers/location_controller.dart';

class ShakePage extends StatefulWidget {
  const ShakePage({Key? key}) : super(key: key);

  @override
  State<ShakePage> createState() => _ShakePageState();
}

class _ShakePageState extends State<ShakePage> {
  final Telephony telephony = Telephony.instance;
  final player = AudioPlayer();
  final LocationController locationController = Get.put(LocationController());
  List<String> recipients = ["7010054699"];

  void wrongInfo(String error) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Rakshak",
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
            content: Text(
              error,
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
            titlePadding: const EdgeInsets.all(20),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary)))
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    ShakeDetector detector = ShakeDetector.autoStart(
        minimumShakeCount: 3,
        onPhoneShake: () async {
          // Do stuff on phone shake
          // await AudioPlayer().clearAssetCache();
          wrongInfo("Message sent successfully");
          telephony.sendSms(
              to: recipients[0],
              message:
                  "Help Help Help!!, My Location is : http://www.google.com/maps/place/${locationController.currentPosition.value.latitude},${locationController.currentPosition.value.longitude}");
          // await player.play(AssetSource("siren.mp3"));
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Text(
          "Shake the phone 3 times to send SOS message to your emergency contacts.",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
