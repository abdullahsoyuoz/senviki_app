import 'dart:ui';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:senviki_app/Model/FakeNewsEntity.dart';
import 'package:senviki_app/Pages/Detail/NewsDetailPage.dart';
import 'package:senviki_app/Utility/Colors.dart';
import 'package:senviki_app/Utility/FakeData.dart';
import 'package:senviki_app/Utility/util.dart';

class CategoryDetailPage extends StatefulWidget {
  FakeCategory item;
  CategoryDetailPage(this.item);
  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200,
                automaticallyImplyLeading: false,
                centerTitle: true,
                floating: true,
                pinned: true,
                backgroundColor: AppColors.secondaryColor.withOpacity(.9),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(FontAwesomeIcons.chevronLeft),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  title: Text(
                    widget.item.title,
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                    softWrap: true,
                  ),
                  background: Image.network(
                    widget.item.imageUrl,
                    color: Colors.black.withOpacity(0.7),
                    colorBlendMode: BlendMode.darken,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ];
          },
          body: Container(
            width: getSize(context),
            height: MediaQuery.of(context).size.height,
            child: ListView(
              shrinkWrap: true,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.item.newsList.length,
                  itemBuilder: (context, index) {
                    return buildNewsItem(widget.item.newsList[index]);
                  },
                )
              ],
            ),
          ),
        ));
  }

  Widget buildNewsItem(FakeNewsEntity item) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => NewsDetailPage(item),
            ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
            width: getSize(context),
            height: getSize(context) * 0.6,
            margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 5, offset: Offset(0, 0))
                ]),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                  child: Image.network(
                    item.newsImageUrl,
                    fit: BoxFit.cover,
                    width: getSize(context),
                    height: getSize(context) * 0.3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    item.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.calendarAlt,
                            color: AppColors.secondaryColor,
                            size: 15,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(getRandomDate(item),
                                  style: GoogleFonts.openSans(
                                      color: AppColors.secondaryColor,
                                      fontWeight: FontWeight.w600))),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

// #TEMP
String getRandomLike() {
  return Faker().randomGenerator.integer(99).toString();
}
