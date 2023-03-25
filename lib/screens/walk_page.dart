import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:rakshak/components/my_button.dart';

class WalkPage extends StatelessWidget {
  const WalkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 280,
            child: MyButton(
              onTap: () {
                FlutterBackgroundService().invoke("setAsBackground");
              },
              text: 'Start Service',
            ),
          ),
          SizedBox(height: 20,),
          Container(
            height: 80,
            width: 280,
            child: MyButton(
              onTap: () {
                FlutterBackgroundService().invoke("stopService");
              },
              text: 'Stop Service',
            ),
          ),
        ],
      ),
    );
  }
}
