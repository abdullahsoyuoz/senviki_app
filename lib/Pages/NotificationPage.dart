import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:senviki_app/Utility/Colors.dart';
import 'package:senviki_app/Utility/FakeData.dart';
import 'package:senviki_app/Utility/util.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text('Bildirimler',
            style: GoogleFonts.openSans(
                fontSize: 18,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600)),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(
              FontAwesomeIcons.syncAlt,
              color: AppColors.secondaryColor,
            ),
          )
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        itemCount: FakeData.fakeNotify.length,
        itemBuilder: (context, index) {
          var item = FakeData.fakeNotify[index];
          return buildNotifyItem(item);
        },
      ),
    );
  }

  Widget buildNotifyItem(FakeNotify item) {
    return Container(
      height: 120,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 3)]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  item.imageUrl,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '${item.title}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.clock,
                            size: 15,
                            color: AppColors.secondaryColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text(getDateFormattedMonthString(
                                item.time)),
                          )
                        ],
                      ),
                    
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
