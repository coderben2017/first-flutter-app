import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.green), home: RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = [];
  final Set<WordPair> _saved = new Set<WordPair>();
  final textStyle = TextStyle(fontSize: 18);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16),
        itemBuilder: (BuildContext buildContext, int i) {
          if (i.isOdd) {
            return Divider();
          }

          if (i >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[i]);
        });
  }

  Widget _buildRow(WordPair wordPair) {
    final bool _isSaved = _saved.contains(wordPair);
    return ListTile(
      title: Text(wordPair.asPascalCase, style: textStyle),
      trailing: Icon(
        _isSaved ? Icons.favorite : Icons.favorite_border,
        color: _isSaved ? Colors.red : Colors.black,
      ),
      onTap: () {
        setState(() {
          if (_isSaved) {
            _saved.remove(wordPair);
          } else {
            _saved.add(wordPair);
          }
        });
      },
    );
  }

  void _handleFavoritesShow() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> _listTiles = _saved.map((WordPair wordPair) {
        return ListTile(
          title: Text(wordPair.asPascalCase, style: textStyle),
        );
      });
      final List<Widget> _dividedListTiles =
          ListTile.divideTiles(tiles: _listTiles, context: context).toList();
      return Scaffold(
        appBar: AppBar(
          title: Text('已收藏列表'),
        ),
        body: ListView(
          children: _dividedListTiles,
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('单词列表'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _handleFavoritesShow,
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}

void main() {
  runApp(new App());
}
