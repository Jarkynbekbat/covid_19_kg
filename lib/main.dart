// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'ui/screens/home.dart';

void main() {
  runApp(
    // EasyLocalization(
    //   path: '/langs/langs.csv',
    //   saveLocale: true,
    //   supportedLocales: [
    //     Locale('ky', 'KG'),
    //     Locale('ru', 'RU'),
    //   ],
    // child:
    MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID-19 KG',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.locale,
    );
  }
}
