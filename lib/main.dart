import 'package:flutter/material.dart';
import 'type_ahead.dart';
import 'sample_api.dart';
import 'search.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Typeahead Demo',
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new MyHomePage(title: 'Flutter Typeahead Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SampleApi api;
  Search search;

  _MyHomePageState() {
    api = new SampleApi<String>();
    search = new Search(api);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Typeahead demo'),
      ),
      body: new Column(
        children: <Widget>[
          //new TypeAhead(api: api),
          new TypeAhead(search: search),
        ],
      ),
    );
  }
}
