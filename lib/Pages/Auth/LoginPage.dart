import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:senviki_app/Pages/Auth/LoginWithEmailPage.dart';
import 'package:senviki_app/Pages/MainPageView.dart';
import 'package:senviki_app/Service/Auth.dart';
import 'package:senviki_app/Service/SharedPrefs.dart';
import 'package:senviki_app/Utility/Colors.dart';
import 'package:senviki_app/Utility/util.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () async {
                await loginAnonymController(context);
              },
              child: Text(
                'Anonim devam et',
                style: GoogleFonts.openSans(color: AppColors.primaryColor),
              )),
          TextButton(
            onPressed: () {
              //
            },
            child: Icon(
              FontAwesomeIcons.globe,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: getSize(context),
        child: Column(
          children: [
            Expanded(
                child: Center(child: Image.asset('asset/senvikilogo.png'))),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 40,
                    right: 40,
                  ),
                  child: FlatButton(
                    onPressed: () async {
                      // FIXME:
                      await loginWithGoogleController(context);
                    },
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.google,
                          color: Colors.white,
                          size: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Sign in with Google',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    color: AppColors.googleBlue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Divider(
                    height: 20,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 40,
                    right: 40,
                  ),
                  child: FlatButton(
                    onPressed: () async {
                      // FIXME:
                      await loginAnonymController(context);
                    },
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.apple,
                          color: Colors.white,
                          size: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Sign in with Apple',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    color: AppColors.appleBlack,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 50),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => LoginWithEmailPage(),
                          ));
                    },
                    child: Text(
                      'Email ile devam et',
                      style: GoogleFonts.openSans(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future loginAnonymController(BuildContext context) async {
  await AppAuth().signInAnonym().then((value) {
    Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(
      builder: (context) {
        return MainPageView();
      },
    ), (route) => false);
  });
}

Future loginWithGoogleController(BuildContext context) async {
  await AppAuth().signInGoogle().then((value) {
    if (value.user != null) {
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(
        builder: (context) {
          return MainPageView();
        },
      ), (route) => false);
    }
  });
}
