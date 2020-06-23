import 'package:flutter/foundation.dart';

class StatisticData {
  final int allCases;
  final int todayCases;
  final int recovered;
  final int deaths;

  StatisticData({
    @required this.allCases,
    @required this.todayCases,
    @required this.recovered,
    @required this.deaths,
  });
}
