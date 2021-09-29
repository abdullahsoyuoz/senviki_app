import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senviki_app/Pages/CategoryPage.dart';
import 'package:senviki_app/Pages/HomePage.dart';
import 'package:senviki_app/Pages/NotificationPage.dart';
import 'package:senviki_app/Pages/ProfilePage.dart';
import 'package:senviki_app/Utility/Colors.dart';

class MainPageView extends StatefulWidget {
  @override
  MainPageViewState createState() => MainPageViewState();
}

class MainPageViewState extends State<MainPageView> {
  int currentPageIndex = 0;
  PageController pageController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  List<Widget> pages = [
    HomePage(FirebaseAuth.instance.currentUser),
    CategoryPage(),
    NotificationPage(),
    ProfilePage(),
    //
    Scaffold(
      body: Center(
        child: Text('Giriş Yap'),
      ),
    )
  ];

  List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(label: 'Home', icon: Icon(FontAwesomeIcons.home)),
    BottomNavigationBarItem(
        label: 'Kategoriler', icon: Icon(FontAwesomeIcons.thLarge)),
    BottomNavigationBarItem(
        label: 'Bildirimler', icon: Icon(FontAwesomeIcons.solidBell)),
    BottomNavigationBarItem(
        label: 'Profil', icon: Icon(FontAwesomeIcons.solidUser)),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.secondaryColor,
        unselectedItemColor: Colors.grey.shade400,
        items: bottomNavBarItems,
        currentIndex: currentPageIndex,
        onTap: (value) {
          if (value == 3) {
            currentPageIndex = loginControl(context) ? 3 : 4;
          }
          setState(() {
            currentPageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
      body: Scaffold(
        body: PageView.builder(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          itemCount: pages.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => pages[currentPageIndex],
        ),
      ),
    );
  }

  bool loginControl(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      debugPrint('currentUser != null');
      if (FirebaseAuth.instance.currentUser.isAnonymous) {
        debugPrint('false');
        return false;
      }
    } else
      debugPrint('true');
    return true;
  }
}
