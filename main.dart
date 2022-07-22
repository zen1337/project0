import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'nudge',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
            )
        )
      ),
      home: MyHomePage(title: 'nudge'),
    );
  }
}

class NudgeItem {
  final String title;
  final String text;

  const NudgeItem({
    required this.text,
    required this.title
});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<NudgeItem> items = [
    NudgeItem(
      title: "nudge!",
      text:  "remember to nudge bro",
    ),
    NudgeItem(
      title: "nudge!",
      text:  "remember to nudge broz",
    ),
    NudgeItem(
      title: "nudge!",
      text:  "remember to nudge bros",
    ),
  ];

   var _text = "test";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('nudge'),
      ),
        body: Center(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                return nudgeCard(items[item]);
              },
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton.icon(onPressed: () => setState(() {
              _text = "ADD";
            }), icon: Icon(
              Icons.add,
              color: Colors.greenAccent,
            ), label: Text("ADD")),
            ElevatedButton.icon(onPressed: () => setState(() {
              _text = "EDIT";
            }), icon: Icon(
              Icons.edit,
              color: Colors.white,
            ), label: Text("EDIT")),
            ElevatedButton.icon(onPressed: () => setState(() {
              _text = "DEL";
            }), icon: Icon(
              Icons.clear,
              color: Colors.red
            ), label: Text("DEL"))
          ],
      ),
    );
  }
  Widget nudgeCard({
    required NudgeItem item,
}) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      color: Colors.amber,
      width: 400,
      height: 100,
      child: Center(child: Text('$index'),),
    ),
  );
  }
void main() {
  runApp(const MyApp());
}

