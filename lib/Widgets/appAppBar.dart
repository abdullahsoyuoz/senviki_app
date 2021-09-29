import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:senviki_app/Pages/Auth/LoginPage.dart';
import 'package:senviki_app/Service/Auth.dart';

AppBar appAppBar(BuildContext context, User user) {
    return AppBar(
      title: Text(user.displayName != null ? user.displayName : user.email.toString()),
      backgroundColor: Colors.black,
      actions: [
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () async{
            AppAuth()
                .signOut()
                .whenComplete(() => Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                    (route) => false));
          },
        )
      ],
    );
  }