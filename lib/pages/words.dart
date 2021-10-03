import 'package:flutter/material.dart';
import 'package:gilak/db/db.dart';
import 'package:gilak/models/word.dart';
import 'package:gilak/pages/word.dart';

class WordCard extends StatelessWidget {
  final Word word;

  WordCard({this.word});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 50,
      minWidth: 90,
      child: OutlineButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WordPage(word: word)),
          );
        },
        borderSide: BorderSide(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
        textColor: Colors.white,
        color: Color.fromARGB(255, 98, 88, 237),
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Text(word.word,
                style: TextStyle(fontSize: 20.0, fontFamily: "Yekan")),
            SizedBox(height: 10),
            Divider(
              color: Colors.white,
              height: 1,
            ),
            SizedBox(height: 20),
            Text(word.meaning,
                textAlign: TextAlign.justify,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: "Yekan",
                  color: Color.fromARGB(255, 206, 186, 195),
                )),
          ],
        ),
      ),
    );
  }
}

class WordsPage extends StatefulWidget {
  final String alphabet;

  WordsPage({this.alphabet});
  @override
  _WordsPageState createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  var db = DB();
  List<Word> _words = List<Word>();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    db.getWords(widget.alphabet).then((words) => setState(() {
          _words = words;
          _loading = false;
        }));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    db.closeDB();
  }

  Widget _getBody() {
    if (_loading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: _words.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: WordCard(
              word: _words[index],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 38, 49),
      body: _getBody(),
    );
  }
}
