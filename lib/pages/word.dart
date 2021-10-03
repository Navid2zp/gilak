import 'package:flutter/material.dart';
import 'package:gilak/models/word.dart';

class WordPage extends StatelessWidget {
  final Word word;
  WordPage({this.word});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 38, 49),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(word.word,
                  style: TextStyle(
                      color: Color.fromARGB(255, 250, 248, 248),
                      fontFamily: "Yekan",
                      fontSize: 54)),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(word.meaning,
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Color.fromARGB(255, 206, 186, 195),
                        fontFamily: "Yekan",
                        height: 1.2,
                        fontSize: 18)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("(منبع: gdic.ir)",
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Yekan",
                      height: 1.2,
                      fontSize: 12)),
            )
          ],
        ),
      ),
    );
  }
}
