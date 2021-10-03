import 'package:flutter/material.dart';
import 'package:gilak/pages/alphabet.dart';
import './pages/home.dart';
import './pages/search.dart';


void main() {
  
  runApp(MaterialApp(
    title: 'Gilak',
    
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    theme: ThemeData(fontFamily: "Yekan", primaryColor: Color.fromARGB(255, 35, 38, 49)),
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => MyApp(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/search': (context) => WordSearch(),
      '/word': (context) => WordSearch(),
      '/wordsAlphabetList': (context) => WordsAlphabetList(),
    },
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'گیلک - فرهنگ لغت گیلکی',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'گیلک - فرهنگ لغت گیلکی'),
    );
  }
}


