import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:rakshak/components/my_button.dart';
import 'package:rakshak/controllers/location_controller.dart';
import 'package:telephony/telephony.dart';

var logger = Logger(
  filter: null, // Use the default LogFilter (-> only log in debug mode)
  printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
  output: null, // Use the default LogOutput (-> send everything to console)
);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Telephony telephony = Telephony.instance;
  final LocationController locationController = Get.put(LocationController());
  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      logger.v("Denied");
    } else {
      Position currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      logger.v(
          "Allowed ${currentLocation.latitude} ${currentLocation.longitude}");
      locationController.currentPosition.value =
          LatLng(currentLocation.latitude, currentLocation.longitude);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentLocation();
    super.initState();
  }
  List<String> recipients = ["7010054699"];
  sendDetails(){
    telephony.sendSms(to: recipients[0], message: "Help Help Help!!, My Location is : http://www.google.com/maps/place/${locationController.currentPosition.value.latitude},${locationController.currentPosition.value.longitude}");
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Stack(
        children:
        [Obx(() {
          return locationController.currentPosition.value != const LatLng(0, 0)
              ? GoogleMap(
            myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  initialCameraPosition: CameraPosition(
                      target: locationController.currentPosition.value, zoom: 10),
                )
              : const Center(child: Text("Loading....."));
        }),
        Positioned(bottom: 70, right: 140, child: Container(height: 80, child: MyButton(onTap: sendDetails, text: "SOS")))]
      ),
    ));
  }
}
