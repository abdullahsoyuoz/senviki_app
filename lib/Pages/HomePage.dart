import 'dart:ui';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:senviki_app/Model/FakeNewsEntity.dart';
import 'package:senviki_app/Pages/Detail/NewsDetailPage.dart';
import 'package:senviki_app/Pages/SearchPage.dart';
import 'package:senviki_app/Utility/Colors.dart';
import 'package:senviki_app/Utility/FakeData.dart';
import 'package:senviki_app/Utility/util.dart';

class HomePage extends StatefulWidget {
  User user;
  HomePage(this.user);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController;
  int currentCarouselIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
        leadingWidth: 100,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'asset/senvikilogo.png',
            fit: BoxFit.cover,
            height: AppBar().preferredSize.height - 10,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => SearchPage(),
                    ));
              },
              child: Icon(
                FontAwesomeIcons.search,
                color: AppColors.secondaryColor,
              ),
            ),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              child: SizedBox(
                width: getSize(context),
                height: getSize(context) * 0.5,
                child: Carousel(
                  boxFit: BoxFit.cover,
                  autoplay: false,
                  dotSize: 8,
                  dotIncreaseSize: 1.05,
                  dotIncreasedColor: AppColors.secondaryColor,
                  indicatorBgPadding: 10,
                  dotBgColor: Colors.transparent,
                  images: FakeData.fakeNewsCarouselList.map((item) {
                    return buildCarouselItem(context, item);
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      RotatedBox(
                        quarterTurns: 1,
                        child: SizedBox(
                          height: 10,
                          width: 30,
                          child: Divider(
                            thickness: 5,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                      Text(
                        'Popüler Haberler',
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Tümünü gör',
                          style:
                              GoogleFonts.openSans(color: Colors.grey.shade500),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: FakeData.fakeNewsList.length,
                itemBuilder: (context, index) {
                  var item = FakeData.fakeNewsList[index];
                  return buildNewsItem(item);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCarouselItem(BuildContext context, FakeNewsEntity item) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => NewsDetailPage(item),
          )),
      child: Container(
        width: getSize(context),
        height: getSize(context) * 0.4,
        child: Stack(
          fit: StackFit.loose,
          children: [
            SizedBox.expand(
              child: Image.network(
                item.newsImageUrl,
                width: getSize(context),
                height: getSize(context) * 0.4,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(100)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            FontAwesomeIcons.clock,
                            color: Colors.white,
                            size: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text(
                                '${getDateFormattedMonthString(item.publishingDate.random())}',
                                style: GoogleFonts.openSans(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.secondaryColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(100)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Text('${item.category.toString()}',
                        style: GoogleFonts.openSans(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: getSize(context),
                height: getSize(context) * 0.2,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
                child: Text(
                  '${item.title}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                  style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildNewsItem(FakeNewsEntity item) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => NewsDetailPage(item),
          )),
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      item.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      softWrap: true,
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          item.category,
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    item.newsImageUrl,
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FontAwesomeIcons.clock,
                        color: Colors.grey,
                        size: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Text(
                            '${getDateFormattedMonthString(item.publishingDate.random())}',
                            style: GoogleFonts.openSans(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
