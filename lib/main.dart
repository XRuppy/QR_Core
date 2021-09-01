import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:manusa_qrcore/home_screen.dart';

import 'languajes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // Inglés
        const Locale('es'), // Español
        const Locale('fr'), // Francés
        const Locale('pt'), // Portugués
      ],
      debugShowCheckedModeBanner: false,
      title: 'QR Core',
      theme: ThemeData(fontFamily: "Product Sans",visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Colors.indigo, accentColor: Colors.indigoAccent,),
      home: HomeScreen(),
    );
  }
}
