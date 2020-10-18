import 'package:flutter/material.dart';
import 'package:flutter_markdown_editor/flutter_markdown_editor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('create widget', (WidgetTester tester) async {
    MarkDownEditor editor = MarkDownEditor();
    await tester.pumpWidget(MyWidget(
      child: editor.preview,
    ));
  });
}

class MyWidget extends StatelessWidget {
  final Widget child;

  const MyWidget({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }
}
