import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:senviki_app/Pages/Detail/CategoryDetailPage.dart';
import 'package:senviki_app/Utility/Colors.dart';
import 'package:senviki_app/Utility/FakeData.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Center(
            child: Text('Kategoriler',
                style: GoogleFonts.openSans(
                    fontSize: 18,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600))),
        leadingWidth: 120,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {},
              child: Icon(
                FontAwesomeIcons.syncAlt,
                color: AppColors.secondaryColor,
              ),
            ),
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: FakeData.fakeCategoryList.map((item) {
          return buildCategoryItem(item);
        }).toList(),
      ),
    );
  }

  Widget buildCategoryItem(FakeCategory item) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => CategoryDetailPage(item),
            ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: AspectRatio(
          aspectRatio: 1,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                item.imageUrl,
                colorBlendMode: BlendMode.srcATop,
                color: Colors.black.withOpacity(.5),
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    item.title,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
