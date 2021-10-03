import 'package:flutter/material.dart';
import 'package:gilak/pages/search.dart';
import 'package:gilak/db/db.dart';
import 'package:gilak/pages/word.dart';
import 'package:gilak/pages/alphabet.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void rundb() async {
    await db.initializeDatabase();
  }

  void _randomWordHandler() {
    var db = DB();
    db.randomWord().then((word) => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WordPage(word: word)),
          )
        });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title,
              textDirection: TextDirection.rtl, textAlign: TextAlign.center),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 35, 38, 49),
        ),
        backgroundColor: Color.fromARGB(255, 35, 38, 49),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: <Widget>[
                  ButtonTheme(
                    height: 60,
                    child: Expanded(
                      flex: 1,
                      child: OutlineButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WordSearch()),
                          );
                        },
                        borderSide: BorderSide(color: Colors.white),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(2.0)),
                        textColor: Colors.white,
                        color: Color.fromARGB(255, 247, 77, 86),
                        padding: const EdgeInsets.all(10.0),
                        child: new Text("جستجو",
                            style:
                                TextStyle(fontSize: 20.0, fontFamily: "Yekan")),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: ButtonTheme(
                      height: 90,
                      // minWidth: double.infinity,
                      child: OutlineButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WordsAlphabetList()),
                          );
                        },
                        borderSide: BorderSide(color: Colors.white),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(2.0)),
                        textColor: Colors.white,
                        color: Color.fromARGB(255, 247, 77, 86),
                        padding: const EdgeInsets.all(5.0),
                        child: new Text("لیست لغات",
                            style:
                                TextStyle(fontSize: 20.0, fontFamily: "Yekan")),
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                  Expanded(
                    flex: 10,
                    child: ButtonTheme(
                      height: 90,
                      // minWidth: 170,
                      child: OutlineButton(
                        onPressed: _randomWordHandler,
                        borderSide: BorderSide(color: Colors.white),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(2.0)),
                        textColor: Colors.white,
                        color: Color.fromARGB(255, 98, 88, 237),
                        padding: const EdgeInsets.all(5.0),
                        child: new Text("لغت تصادفی",
                            style:
                                TextStyle(fontSize: 20.0, fontFamily: "Yekan")),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
