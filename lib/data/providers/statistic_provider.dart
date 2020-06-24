import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

import '../models/statistic_data.dart';

class StatisticProvider {
  final String url = 'https://covid.kg/';

  Future<StatisticData> getStatisticData() async {
    final response = await http.get(url);

    dom.Document document = parser.parse(response.body);
    //

    String dateText = document
        .getElementsByClassName('data-name ml-3 mb-3')[0]
        .text
        .substring(32);

    int allCases =
        int.parse(document.getElementsByClassName('data-active')[0].innerHtml);
    int todayCases =
        int.parse(document.getElementsByClassName('data-today')[0].innerHtml);
    int recovered = int.parse(
        document.getElementsByClassName('data-recovered')[0].innerHtml);
    int deaths =
        int.parse(document.getElementsByClassName('data-deatg')[0].innerHtml);

    return StatisticData(
      date: dateText,
      allCases: allCases,
      todayCases: todayCases,
      recovered: recovered,
      deaths: deaths,
    );
  }
}
