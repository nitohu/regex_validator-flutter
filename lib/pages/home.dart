import "package:flutter/material.dart";

class HomePage extends StatefulWidget {

  final Map<String, bool> _settings;

  HomePage(this._settings);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _regexInput = TextEditingController();
  final TextEditingController _testInput  = TextEditingController();

  List<String> matches = [];
  Color regexInputColor;

  void _validate() {

    RegExp regex;

    try {
    regex = RegExp(
      _regexInput.text,
      caseSensitive: widget._settings["case-sensitive"],
      multiLine: widget._settings["multiline"]);
    } catch(Exception) {
      regex = RegExp("");
    }
    Iterable<Match> m = regex.allMatches(_testInput.text);

    setState(() {
      matches = [];

      for(Match x in m) {
        if(x.group(0) != "") {
          matches.add(x.group(0));
        }
      }
    });

    print(matches);
  }

  Widget _buildMatchesList() {

    if(matches.isNotEmpty) {
      return Column(
        children: <Widget>[
          Text(
                "Matches:",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: matches.length,
                  itemBuilder: (BuildContext ctx, int i) {
                    return ListTile(
                      title: Text(matches[i])
                    );
                  },
                )
              )
        ]
      );
    } 

    return Container();

  }

  @override
  Widget build(BuildContext context) {

    _regexInput.addListener(_validate);
    _testInput.addListener(_validate);

    regexInputColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text("Regex Validator"),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, "/settings");
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 30.0),
        child: ListView(
          children: <Widget>[
            TextField(
              autocorrect: false,
              controller: _regexInput,
              style: TextStyle(
                fontSize: 18
              ),
              decoration: InputDecoration(
                labelText: "RegEx",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: regexInputColor)
                )
              ),
            ),
            SizedBox(height: 15),
            TextField(
              maxLines: null,
              controller: _testInput,
              style: TextStyle(
                fontSize: 18
              ),
              decoration: InputDecoration(
                hintText: "Test Input",
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 20),
            _buildMatchesList()
          ],
        )
      )
    );
  }
}