import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:senviki_app/Pages/Auth/LoginPage.dart';
import 'package:senviki_app/Utility/Colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => LoginPage(),), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('asset/senvikilogo.png'),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: SpinKitChasingDots(
                color: AppColors.primaryColor,
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
