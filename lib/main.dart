import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:morningmagic/pages/loadingPage.dart';
import 'package:morningmagic/pages/menuPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp]
  ).then((_) async{
    runApp(
      EasyLocalization(
        child: MyApp(),
        supportedLocales: [
          Locale('en'),
          Locale('ru'),
        ],
        path: 'assets/langs',
        fallbackLocale: Locale('en'),
        // startLocale: Locale('de'),
        // saveLocale: false,
        useOnlyLangCode: true,
      )
    );
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/start': (context) => StartScreen(),
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasyLocalization.of(context).delegate,
      ],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      home: LoadingPage(),
    );
  }
  
}
