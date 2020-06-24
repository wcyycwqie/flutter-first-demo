import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  print('main start');
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordOne = new WordPair.random();
    return new MaterialApp(
      title: 'Welcome to Flutter ',
      theme: new ThemeData(
        primaryColor: Color(0xFF454545),
      ),
      home: RdWords(),
    );
  }
}

class RdWords extends StatefulWidget {
  @override
//  createState() => new RandomWordsState();
  createState() {
    return new RandomWordsState();
  }
}

class RandomWordsState extends State<RdWords> {
  @override
  final _suggtionsList = <WordPair>[];

  final _saved = new Set<WordPair>();

  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;

          if (index >= _suggtionsList.length) {
            _suggtionsList.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggtionsList[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    print('build row');
    print(alreadySaved);

    return new ListTile(
      leading: new Icon(
        Icons.star,
        color: Color(0xFF66ccFF),
      ),
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : Colors.yellow,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();
//    return new Text(wordPair.asCamelCase);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Name List:'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    print('跳转哦');
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile
          .divideTiles(
            context: context,
            tiles: tiles,
          )
          .toList();
          print('*******new widget ************');
          print(divided);
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved List'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}
