import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evil Insult',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Evil Insult'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String insult ="Get Ready to see some evil insult.";

  void _incrementCounter() async{
    var url = 'https://evilinsult.com/generate_insult.php?lang=en&type=json';
    var response = await http.get(url, headers: {
      'Accept': 'application/json',
    });

    setState(()  {
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        var itemCount = jsonResponse['insult'];
        insult = itemCount.toString();
        print('Number of books about http: $itemCount.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              insult,style: Theme.of(context).textTheme.headline5,textAlign:TextAlign.center,
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Submit',
        child: Icon(Icons.rotate_right_outlined),
        elevation: 15.0,
        autofocus: true,
        splashColor: Colors.purple,
      ),
    );
  }
}
