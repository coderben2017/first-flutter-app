import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = [];
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
    return ListTile(
      title: Text(wordPair.asPascalCase, style: textStyle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSuggestions(),
    );
  }
}

void main() {
  runApp(new App());
}
