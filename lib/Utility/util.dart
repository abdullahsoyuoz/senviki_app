import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:senviki_app/Model/FakeNewsEntity.dart';

double getSize(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

class WithoutGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

String getRandomDate(FakeNewsEntity item) {
  return '${item.publishingDate.random().day.toString()}.${item.publishingDate.random().month.toString()}.${item.publishingDate.random().year.toString()}';
}

String getRandomLike() {
  return Faker().randomGenerator.integer(99).toString();
}

String getDateFormattedMonthString(DateTime item) {
  return '${item.day} ${getMonth(item.month)} ${item.year}';
}

String getMonth(int month) {
  switch (month) {
    case 1:
      return 'Ocak';
      break;
    case 2:
      return 'Şubat';
      break;
    case 3:
      return 'Mart';
      break;
    case 4:
      return 'Nisan';
      break;
    case 5:
      return 'Mayıs';
      break;
    case 6:
      return 'Haziran';
      break;
    case 7:
      return 'Temmuz';
      break;
    case 8:
      return 'Ağustos';
      break;
    case 9:
      return 'Eylül';
      break;
    case 10:
      return 'Ekim';
      break;
    case 11:
      return 'Kasım';
      break;
    case 12:
      return 'Aralık';
      break;
    default:
      // ignore: unnecessary_statements
      '?';
      break;
  }
}
