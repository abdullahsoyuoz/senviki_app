import 'package:random_date/random_date.dart';

class FakeNewsEntity {
  int newsID;
  String title;
  String description;
  String context;
  String newsImageUrl;
  RandomDate publishingDate;
  String publisherName;
  String establishment;
  String category;
  FakeNewsEntity({
    this.newsID,
    this.title = "",
    this.description = "",
    this.context = "",
    this.newsImageUrl = "",
    this.publishingDate,
    this.publisherName = "",
    this.establishment = "",
    this.category,
  });
}
