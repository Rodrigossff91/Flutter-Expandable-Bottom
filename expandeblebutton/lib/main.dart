import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _expanded = false;

  double currentAltura = 100;
  double maxAltura = 500;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var maxHeight = MediaQuery.of(context).size.height * 0.80;
    final size = MediaQuery.of(context).size;
    final menuWidht = size.width * 0.5;

    double min = 200;

    double max = 500;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _expanded = !_expanded;
            if (_expanded) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
          });
        },
        onVerticalDragStart: (details) {
          setState(() {
            _controller.forward();
          });
        },
        onVerticalDragUpdate: (details) {
          setState(() {
            _controller.forward();
            max = max - details.delta.dy;
          });
        },
        onVerticalDragEnd: (details) {
          setState(() {
            _controller.reverse();
            _expanded = false;
          });
        },
        child: AnimatedBuilder(
            animation: _controller,
            builder: (context, snapshot) {
              final value = _controller.value;
              return Stack(
                children: <Widget>[
                  Positioned(
                      child: Container(
                          color: Colors.red,
                          width: size.width,
                          height: lerpDouble(min, max, value))),
                ],
              );
            }),
      ),
    );
  }
}
