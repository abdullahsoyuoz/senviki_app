import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:senviki_app/Model/FakeNewsEntity.dart';
import 'package:senviki_app/Pages/Detail/NewsCommentsPage.dart';
import 'package:senviki_app/Service/CommentsFirestore.dart';
import 'package:senviki_app/Utility/Colors.dart';
import 'package:senviki_app/Utility/util.dart';
import 'package:senviki_app/Widgets/appSnackbar.dart';

class NewsDetailPage extends StatefulWidget {
  FakeNewsEntity item;
  NewsDetailPage(this.item);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  bool isLiked = false;
  bool hasBookmark = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: getSize(context) * 0.7,
              collapsedHeight: SliverAppBar().toolbarHeight + 1,
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.secondaryColor,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  widget.item.newsImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () {},
                    child: Icon(FontAwesomeIcons.shareAlt),
                  ),
                )
              ],
              leading: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(FontAwesomeIcons.chevronLeft)),
            )
          ];
        },
        body: Container(
          width: getSize(context),
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(
                      widget.item.category,
                      style: GoogleFonts.openSans(color: Colors.black),
                    ),
                    backgroundColor: Colors.grey.shade300,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.solidCalendar,
                      size: 13,
                      color: AppColors.secondaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0),
                      child: Text(
                          getDateFormatted(widget.item.publishingDate.random()),
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColors.secondaryColor)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '${widget.item.title}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Divider(
                indent: 0,
                endIndent: getSize(context) * 0.65,
                thickness: 3,
                color: AppColors.secondaryColor,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) =>
                                  NewsCommentsPage(widget.item),
                            ));
                      },
                      color: AppColors.secondaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.comment,
                            color: Colors.white,
                            size: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text('Yorumlar',
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text(
                  '${widget.item.description}',
                  style: GoogleFonts.openSans(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getDateFormatted(DateTime item) {
  return '${item.day}.${item.month}.${item.year}';
}

String getRandomLike() {
  return Faker().randomGenerator.integer(99).toString();
}

String getCommentCount(int newsId) {
  String count;
  StreamBuilder(
      stream: CommentsFirestoreService.getStream(newsId.toDouble().toString(), false),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox();
        } else if (snapshot.hasError) {
          Scaffold.of(context)
              .showSnackBar(appSnackBar(snapshot.error.toString()));
          return SizedBox();
        } else if (snapshot.hasData) {
          final QuerySnapshot querySnapshot = snapshot.data;
          print('size: ' + querySnapshot.size.toString());
          count = querySnapshot.size.toString();
          return SizedBox();
        }
        return SizedBox();
      });
  print(newsId.toString());
  print(count.toString());
  return count;
}
