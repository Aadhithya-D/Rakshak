import 'package:flutter/material.dart';
import 'package:rakshak/screens/audio_page.dart';
import 'package:rakshak/screens/home_page.dart';
import 'package:rakshak/screens/shake_page.dart';
import 'package:rakshak/screens/walk_page.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({Key? key}) : super(key: key);

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  var myIndex = 0;
  List<Widget> widgetList = [HomePage(), WalkPage(), ShakePage(), SpeechScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: myIndex,children: widgetList,),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.directions_walk), label: "Walk"),
        BottomNavigationBarItem(icon: Icon(Icons.vibration), label: "Shake"),
        BottomNavigationBarItem(icon: Icon(Icons.spatial_audio), label: "Audio")
      ],
      ),
    );
  }
}
