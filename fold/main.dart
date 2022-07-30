// import 'package:flutter/cupertino.dart';
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
      home: const MyHomePage(title: 'nudge'),
    );
  }
}

class NudgeItem {
  final String title;
  final String text;
  final int nindex;

  const NudgeItem({
    required this.text,
    required this.title,
    required this.nindex
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
    const NudgeItem(
      title: "nudge!",
      text:  "remember to nudge bro",
      nindex: 0
    ),
    const NudgeItem(
      title: "nudge!",
      text:  "remember to nudge broz",
      nindex: 1
    ),
    const NudgeItem(
      title: "nudge!",
      text:  "remember to nudge bros",
      nindex: 2
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
            scrollDirection: Axis.vertical,
              itemCount: items.length,
              padding: const EdgeInsets.all(5),
              itemBuilder: (context, index) {
                return nudgeCard(items: items[index],
                    index: index, nindex: items[index].nindex);
              },
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton.icon(onPressed: () => setState(() {
              _text = "ADD";
              items.add(NudgeItem(title: "nudge", text: "nudge bro", nindex: items.length + 1));
            }), icon: const Icon(
              Icons.add,
              color: Colors.greenAccent,
            ), label: const Text("ADD")),
            ElevatedButton.icon(onPressed: () => setState(() {
              _text = "EDIT";
            }), icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ), label: const Text("EDIT")),
            ElevatedButton.icon(onPressed: () => setState(() {
              _text = "DEL";
              items.removeLast();
            }), icon: const Icon(
              Icons.clear,
              color: Colors.red
            ), label: const Text("DEL"))
          ],
      ),
    );
  }
  Widget nudgeCard({items, index, nindex
}) => Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      color: Colors.amber,
      width: 400,
      height: 200,
      child: Stack(children: <Widget> [Align(
          alignment: Alignment.topRight,
          child: Container(
            color: Colors.blue,
              child: Text('$index'))),
      Align(
        alignment: Alignment.topLeft,
        child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Center(child: Text(_text)))
      ),
      Center(
        child: Text(nindex.toString()),
      )])
    ),
  );
  }
void main() {
  runApp(const MyApp());
}

