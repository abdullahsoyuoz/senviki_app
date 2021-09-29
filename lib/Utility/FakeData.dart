import 'package:faker/faker.dart';
import 'package:random_date/random_date.dart';
import 'package:senviki_app/Model/FakeNewsEntity.dart';

class FakeCategory {
  String title;
  String imageUrl;
  List<FakeNewsEntity> newsList;
  FakeCategory(this.title, this.imageUrl, this.newsList);
}

class FakeNotify {
  String title;
  DateTime time;
  String imageUrl;
  FakeNotify(this.title, this.time, {this.imageUrl = 'asset/senvikilogo.png'});
}

class FakeData {
  static List<FakeNewsEntity> fakeNewsCarouselList = [
    FakeNewsEntity(
      newsID: 00000001,
      newsImageUrl: faker.image.image(keywords: ['cars']),
      title: faker.lorem.sentence(),
      description: faker.lorem.sentence() +
          faker.lorem.sentence() +
          faker.lorem.sentence() +
          faker.lorem.sentence() +
          faker.lorem.sentence() +
          faker.lorem.sentence(),
      category: 'Otomobil',
      publishingDate: RandomDate.withStartYear(2005),
    ),
    FakeNewsEntity(
        newsID: 00000002,
        newsImageUrl: faker.image.image(keywords: ['news']),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence(),
        category: 'Gündem',
        publishingDate: RandomDate.withStartYear(2005)),
    FakeNewsEntity(
        newsID: 00000003,
        newsImageUrl: faker.image.image(keywords: ['build']),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence(),
        category: 'Yaşam',
        publishingDate: RandomDate.withStartYear(2005)),
    FakeNewsEntity(
        newsID: 00000004,
        newsImageUrl: faker.image.image(keywords: ['america']),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence(),
        category: 'Politik',
        publishingDate: RandomDate.withStartYear(2005)),
    FakeNewsEntity(
        newsID: 00000005,
        newsImageUrl: faker.image.image(keywords: ['europa']),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence(),
        category: 'Politik',
        publishingDate: RandomDate.withStartYear(2005)),
    ];

  static List<FakeNewsEntity> fakeNewsList = [
    FakeNewsEntity(
      newsID: 00000001,
      newsImageUrl: faker.image.image(keywords: ['cars']),
      title: faker.lorem.sentence(),
      description: faker.lorem.sentence() +
          faker.lorem.sentence() +
          faker.lorem.sentence() +
          faker.lorem.sentence() +
          faker.lorem.sentence() +
          faker.lorem.sentence(),
      category: 'Otomobil',
      publishingDate: RandomDate.withStartYear(2005),
    ),
    FakeNewsEntity(
        newsID: 00000002,
        newsImageUrl: faker.image.image(keywords: ['news']),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence(),
        category: 'Gündem',
        publishingDate: RandomDate.withStartYear(2005)),
    FakeNewsEntity(
        newsID: 00000003,
        newsImageUrl: faker.image.image(keywords: ['build']),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence(),
        category: 'Yaşam',
        publishingDate: RandomDate.withStartYear(2005)),
    FakeNewsEntity(
        newsID: 00000004,
        newsImageUrl: faker.image.image(keywords: ['america']),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence(),
        category: 'Politik',
        publishingDate: RandomDate.withStartYear(2005)),
    FakeNewsEntity(
        newsID: 00000005,
        newsImageUrl: faker.image.image(keywords: ['europa']),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence(),
        category: 'Politik',
        publishingDate: RandomDate.withStartYear(2005)),
    FakeNewsEntity(
        newsID: 00000006,
        newsImageUrl: faker.image.image(keywords: ['apple']),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence(),
        category: 'Teknoloji',
        publishingDate: RandomDate.withStartYear(2005)),
    FakeNewsEntity(
        newsID: 00000007,
        newsImageUrl: faker.image.image(keywords: ['social']),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence(),
        category: 'Yaşam',
        publishingDate: RandomDate.withStartYear(2005)),
    FakeNewsEntity(
        newsID: 00000008,
        newsImageUrl: faker.image.image(keywords: ['football']),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence(),
        category: 'Spor',
        publishingDate: RandomDate.withStartYear(2005)),
    FakeNewsEntity(
        newsID: 00000009,
        newsImageUrl: faker.image.image(keywords: ['operation']),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence(),
        category: 'Politik',
        publishingDate: RandomDate.withStartYear(2005)),
    FakeNewsEntity(
        newsID: 00000010,
        newsImageUrl: faker.image.image(keywords: ['education']),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence() +
            faker.lorem.sentence(),
        category: 'Yaşam',
        publishingDate: RandomDate.withStartYear(2005)),
  ];

  static List<FakeCategory> fakeCategoryList = [
    FakeCategory('Eğlence', faker.image.image(keywords: ['entertainment']),
        fakeNewsList),
    FakeCategory('Spor', faker.image.image(keywords: ['sport']), fakeNewsList),
    FakeCategory(
        'Seyahat', faker.image.image(keywords: ['travel']), fakeNewsList),
    FakeCategory(
        'Teknoloji', faker.image.image(keywords: ['technology']), fakeNewsList),
    FakeCategory(
        'Bilim', faker.image.image(keywords: ['science']), fakeNewsList),
    FakeCategory(
        'Politik', faker.image.image(keywords: ['politics']), fakeNewsList),
    FakeCategory(
        'Otomobil', faker.image.image(keywords: ['automobile']), fakeNewsList),
    FakeCategory('Oyun', faker.image.image(keywords: ['game']), fakeNewsList),
    FakeCategory(
        'Mutfak', faker.image.image(keywords: ['cooking']), fakeNewsList),
    FakeCategory('Yaşam', faker.image.image(keywords: ['life']), fakeNewsList),
  ];

  static List<FakeNotify> fakeNotify = [
    FakeNotify('test', DateTime.now()),
    FakeNotify('SenV2 new version available now!', DateTime.now()),
  ];
}
