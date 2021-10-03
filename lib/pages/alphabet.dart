import 'package:flutter/material.dart';
import 'package:gilak/db/db.dart';
import 'package:gilak/models/word.dart';
import 'package:gilak/pages/words.dart';

class AlphabetButton extends StatelessWidget {
  final String alphabet;

  AlphabetButton({this.alphabet});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 50,
      minWidth: 90,
      child: OutlineButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WordsPage(alphabet: alphabet)),
          );
        },
        borderSide: BorderSide(color: Colors.white),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(2.0)),
        textColor: Colors.white,
        color: Color.fromARGB(255, 98, 88, 237),
        padding: const EdgeInsets.all(10.0),
        child: new Text(alphabet,
            style: TextStyle(fontSize: 18.0, fontFamily: "Yekan")),
      ),
    );
    ;
  }
}

class WordsAlphabetList extends StatefulWidget {
  @override
  _WordsAlphabetListState createState() => _WordsAlphabetListState();
}

class _WordsAlphabetListState extends State<WordsAlphabetList> {
  List<String> _alphabets = List<String>();
  bool _loading = true;
  var db = DB();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db.getAlphabets().then((alphabets) => setState(() {
          _alphabets = alphabets;
          _loading = false;
        }));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    db.closeDB();
  }

  List<Widget> _getWidgets() {
    if (_loading) {
      return <Widget>[
        Center(child: CircularProgressIndicator(backgroundColor: Colors.white))
      ];
    }

    // return _alphabets.map((alphabet) => AlphabetButton(alphabet: alphabet)).toList();
    return <Widget>[
      Center(
        child: Text(
          "لطفا یک حرف را انتخاب کنید",
          style: TextStyle(
              color: Color.fromARGB(255, 206, 186, 195),
              fontFamily: "Yekan",
              height: 1.2,
              fontSize: 16),
        ),
      ),
      SizedBox(height: 30),
      Center(
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 20,
          runSpacing: 20,
          children: <Widget>[
            ..._alphabets
                .map((alphabet) => AlphabetButton(alphabet: alphabet))
                .toList()
          ],
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 38, 49),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _getWidgets(),
            ),
          )
        ],
      ),
    );
  }
}
