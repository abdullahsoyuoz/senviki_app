import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:senviki_app/Pages/Auth/LoginPage.dart';
import 'package:senviki_app/Pages/Profile/EditProfilePage.dart';
import 'package:senviki_app/Service/Auth.dart';
import 'package:senviki_app/Utility/Colors.dart';
import 'package:senviki_app/Utility/util.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isAnonym = FirebaseAuth.instance.currentUser.isAnonymous;
  bool darkModeSwitch = false;
  bool notifySwitch = false;

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text('Profil',
              style: GoogleFonts.openSans(
                  color: AppColors.primaryColor, fontWeight: FontWeight.w600)),
        ),
        body: Container(
          width: getSize(context),
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 5),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: CircleAvatar(
                  backgroundColor: isAnonym ? Colors.black87 : AppColors.secondaryColor,
                  radius: getSize(context) * 0.15,
                  child: isAnonym ? Icon(FontAwesomeIcons.ghost, color: Colors.grey.shade100, size: 40,)
                  : Text(isAnonym ? '' : FirebaseAuth.instance.currentUser.displayName[0],
                    style:GoogleFonts.openSans(color: Colors.white, fontSize: 40),) ,
                ),
              ),
              Center(
                  child: Text(
                isAnonym ? 'Anonim' : FirebaseAuth.instance.currentUser.displayName,
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isAnonym ? SizedBox() : Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: ListTile(
                        onTap: () {},
                        tileColor: Colors.grey.shade100,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30),
                        dense: true,
                        leading: Icon(
                          FontAwesomeIcons.envelope,
                          color: Colors.blue,
                        ),
                        title: Text(FirebaseAuth.instance.currentUser.email,
                          style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    isAnonym ? SizedBox() : Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => EditProfilePage(),
                              ));
                        },
                        tileColor: Colors.grey.shade100,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30),
                        dense: true,
                        leading: Icon(
                          FontAwesomeIcons.edit,
                          color: Colors.purple,
                        ),
                        trailing: Icon(
                          FontAwesomeIcons.chevronRight,
                          color: AppColors.primaryColor,
                          size: 15,
                        ),
                        title: Text(
                          'Profili düzenle',
                          style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    isAnonym ? 
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: ListTile(
                        onTap: () async {
                          await AppAuth()
                              .signOut()
                              .whenComplete(() => Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                  (route) => false));
                        },
                        tileColor: Colors.grey.shade100,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30),
                        dense: true,
                        leading: Icon(
                          FontAwesomeIcons.signInAlt,
                          color: Colors.green,
                        ),
                        trailing: Icon(
                          FontAwesomeIcons.chevronRight,
                          color: AppColors.primaryColor,
                          size: 15,
                        ),
                        title: Text(
                          'Giriş yap',
                          style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ) :
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: ListTile(
                        onTap: () async {
                          await AppAuth()
                              .signOut()
                              .whenComplete(() => Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                  (route) => false));
                        },
                        tileColor: Colors.grey.shade100,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30),
                        dense: true,
                        leading: Icon(
                          FontAwesomeIcons.signOutAlt,
                          color: Colors.redAccent,
                        ),
                        trailing: Icon(
                          FontAwesomeIcons.chevronRight,
                          color: AppColors.primaryColor,
                          size: 15,
                        ),
                        title: Text(
                          'Çıkış yap',
                          style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Text(
                        'Uygulama Ayarları',
                        style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: ListTile(
                        onTap: () {},
                        tileColor: Colors.grey.shade100,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30),
                        dense: true,
                        leading: Icon(
                          FontAwesomeIcons.headset,
                          color: Colors.blue,
                        ),
                        trailing: Icon(
                          FontAwesomeIcons.chevronRight,
                          color: AppColors.primaryColor,
                          size: 15,
                        ),
                        title: Text(
                          'Bizimle iletişime geç',
                          style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: ListTile(
                        onTap: () {},
                        tileColor: Colors.grey.shade100,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30),
                        dense: true,
                        leading: Icon(
                          FontAwesomeIcons.star,
                          color: Colors.orangeAccent,
                        ),
                        trailing: Icon(
                          FontAwesomeIcons.chevronRight,
                          color: AppColors.primaryColor,
                          size: 15,
                        ),
                        title: Text(
                          'Uygulamamızı değerlendir',
                          style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  List<Widget> columnItems = [];
}
