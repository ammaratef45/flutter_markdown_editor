import 'package:flutter/material.dart';
import 'package:flutter_markdown_editor/flutter_markdown_editor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mardown Editor Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final MarkDownEditor markDownEditor = MarkDownEditor();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.border_vertical),
                text: 'Vertical',
              ),
              Tab(
                icon: Icon(Icons.switch_left),
                text: 'In Place',
              ),
              Tab(
                icon: Icon(Icons.settings),
                text: 'Custom',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            markDownEditor.vertical(),
            markDownEditor.inPlace(),
            Column(
              children: [
                markDownEditor.field,
                markDownEditor.preview,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
