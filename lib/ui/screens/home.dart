import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/statistic_data.dart';
import '../../data/providers/statistic_provider.dart';
import '../../localization/demo_localization.dart';
import '../../main.dart';
import '../widgets/statistic_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _changeLanguage(Locale language) {
    Locale _temp;
    switch (language.languageCode) {
      case 'en':
        _temp = Locale(language.languageCode, 'US');
        break;
      case 'ky':
        _temp = Locale(language.languageCode, 'KG');
        break;
      default:
        _temp = Locale(language.languageCode, 'US');
    }
    MyApp.setLocale(context, _temp);
  }

  @override
  Widget build(BuildContext context) {
    StatisticProvider statisticProvider = StatisticProvider();

    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 KG'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              items: [
                DropdownMenuItem(
                  child: Text('KG'),
                  value: Locale('ky', 'KG'),
                ),
                DropdownMenuItem(
                  child: Text('RU'),
                  value: Locale('ru', 'RU'),
                ),
                DropdownMenuItem(
                  child: Text('EN'),
                  value: Locale('en', 'US'),
                ),
              ],
              onChanged: (Locale language) {
                _changeLanguage(language);
              },
              icon: Icon(Icons.language, color: Colors.white),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Container(
          padding: EdgeInsets.all(14.0),
          child: FutureBuilder<StatisticData>(
            future: statisticProvider.getStatisticData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: <Widget>[
                    Text(
                      DemoLocalization.of(context).getTranslatedValue('title'),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      DemoLocalization.of(context).getTranslatedValue('state') +
                          snapshot.data.date,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: 20.0),
                    StatisticCard(
                      color: Colors.red,
                      title: DemoLocalization.of(context)
                          .getTranslatedValue('allCases'),
                      count: snapshot.data.allCases,
                    ),
                    StatisticCard(
                      color: Colors.redAccent,
                      title: DemoLocalization.of(context)
                          .getTranslatedValue('activeCases'),
                      count: snapshot.data.activeCases,
                    ),
                    StatisticCard(
                      color: Colors.green,
                      title: DemoLocalization.of(context)
                          .getTranslatedValue('recovered'),
                      count: snapshot.data.recovered,
                    ),
                    StatisticCard(
                      color: Colors.orange,
                      title: DemoLocalization.of(context)
                          .getTranslatedValue('todayCases'),
                      count: snapshot.data.todayCases,
                    ),
                    StatisticCard(
                      color: Colors.redAccent,
                      title: DemoLocalization.of(context)
                          .getTranslatedValue('deaths'),
                      count: snapshot.data.deaths,
                    ),
                  ],
                );
              }
              if (snapshot.hasError)
                return Center(child: Text(snapshot.error.toString()));
              else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
      floatingActionButton: RaisedButton(
        color: Theme.of(context).accentColor,
        child: Text(
          DemoLocalization.of(context).getTranslatedValue('visitSite'),
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async => await _launchURL(statisticProvider.url),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _onRefresh() async {
    setState(() {});
    await Future.delayed(Duration(seconds: 2));
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
