import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:senviki_app/Pages/Auth/LoginPage.dart';
import 'package:senviki_app/Pages/SplashScreen.dart';
import 'package:senviki_app/Utility/util.dart';

void main() {
  WidgetsFlutterBinding();
  Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    builder: (context, child) {
      return ScrollConfiguration(
        behavior: WithoutGlow(),
        child: child,
      );
    },
    home: AppStarter(),
  ));
}

class AppStarter extends StatefulWidget {
  @override
  _AppStarterState createState() => _AppStarterState();
}

class _AppStarterState extends State<AppStarter> {
  @override
  void initState() {
    updateStatusBar();
    super.initState();
  }

  void updateStatusBar() async {
    await FlutterStatusbarManager.setColor(Colors.black, animated: true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
