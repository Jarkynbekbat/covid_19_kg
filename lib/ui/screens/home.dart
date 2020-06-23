import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/statistic_data.dart';
import '../../data/providers/statistic_provider.dart';
import '../widgets/statistic_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    StatisticProvider statisticProvider = StatisticProvider();

    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 KG'),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Container(
          padding: EdgeInsets.all(14.0),
          child: FutureBuilder<StatisticData>(
            future: statisticProvider.getStatisticData(),
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return ListView(
                  children: <Widget>[
                    Text(
                      'Данные получены из официального сайта о коронавирусе в Кыргызстане',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      snapshot.data.date,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    StatisticCard(
                      color: Colors.red,
                      title: 'Случаев заболевания',
                      count: snapshot.data.allCases,
                    ),
                    StatisticCard(
                      color: Colors.green,
                      title: 'Выздоровело',
                      count: snapshot.data.recovered,
                    ),
                    StatisticCard(
                      color: Colors.orange,
                      title: 'Случаев заболевания на текущий день',
                      count: snapshot.data.todayCases,
                    ),
                    StatisticCard(
                      color: Colors.redAccent,
                      title: 'Случаев смерти',
                      count: snapshot.data.deaths,
                    ),
                  ],
                );
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
          'Посетить сайт',
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
