import 'package:flutter/material.dart';

class TestingScaffold extends StatelessWidget {
  final Widget child;

  const TestingScaffold({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }
}
