// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _text = "test";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('nudge'),
      ),
      body: Center(
        child: Padding(
        padding: const EdgeInsets.all(10),
          child: AspectRatio(
            aspectRatio: 1 / 1.5,
            child: Carousel(
              itemBuilder: (context, index) {
              return nudgeCard(items: items[index],
                  index: index, nindex: items[index].nindex);
              },
            ),
          ),
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
        margin: const EdgeInsets.symmetric(vertical: 1.0),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Colors.amber
        ),
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

typedef OnCurrentItemChangedCallback = void Function(int currentItem);

class Carousel extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  const Carousel({super.key, required this.itemBuilder});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late final PageController _controller;
  late int _currentPage;
  bool _pageHasChanged = false;


  @override
  void initState() {
    super.initState();
    _currentPage = 1;
    _controller = PageController(
      viewportFraction: .85,
      initialPage: _currentPage,
    );
  }

  @override
  Widget build(context) {
    var size = MediaQuery.of(context).size;
    return PageView.builder(
      onPageChanged: (value) {
        setState(() {
          _pageHasChanged = true;
          _currentPage = value;
        });
      },
      controller: _controller,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      itemBuilder: (context, index) => AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          var result = _pageHasChanged ? _controller.page! : _currentPage * 1.0;

          // The horizontal position of the page between a 1 and 0
          var value = result - index;
          value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);

          return Center(
            child: SizedBox(
              height: Curves.easeOut.transform(value) * size.height,
              width: Curves.easeOut.transform(value) * size.width,
              child: child,
            ),
          );
        },
        child: widget.itemBuilder(context, index),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}


void main() {
  runApp(const MyApp());
}

