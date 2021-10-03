import 'package:flutter/material.dart';
import 'package:gilak/db/db.dart';
import 'package:gilak/models/word.dart';
import 'package:gilak/pages/word.dart';

var db = DB();

class WordButton extends StatelessWidget {
  final Word word;

  WordButton({this.word});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 65,
      minWidth: 110,
      child: OutlineButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WordPage(word: this.word)),
          );
        },
        borderSide: BorderSide(color: Colors.white),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(2.0)),
        textColor: Colors.white,
        color: Color.fromARGB(255, 98, 88, 237),
        padding: const EdgeInsets.all(10.0),
        child: new Text(word.word,
            style: TextStyle(fontSize: 15.0, fontFamily: "Yekan")),
      ),
    );
  }
}

class WordSearch extends StatefulWidget {
  @override
  _WordSearchState createState() => _WordSearchState();
}

class _WordSearchState extends State<WordSearch> {
  List<Word> _words = List<Word>();
  bool _searched = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // db = DB();
  }

  void searchWord(String search) {
    if (search.length > 0) {
      db.searchWords(search).then((words) => setState(() {
            _words = words;
            _searched = true;
          }));
    } else {
      setState(() {
        _words = List<Word>();
        _searched = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    db.closeDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text("Search"),
      //   backgroundColor: Color.fromARGB(255, 37, 39, 48),
      // ),
      backgroundColor: Color.fromARGB(255, 35, 38, 49),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Container(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (content) {
                    searchWord(content);
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "چی دنبال ر گردی؟",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromARGB(255, 37, 39, 48),
                      height: 1.0,
                      fontFamily: "Yekan"),
                ),
              )),
              Container(
                child: Divider(
                  height: 5,
                  color: Colors.white,
                ),
                padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Center(
                  child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 10,
                      runSpacing: 20,
                      children: _words
                          .map((word) => WordButton(word: word))
                          .toList()),
                ),
              ),
            ],
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
