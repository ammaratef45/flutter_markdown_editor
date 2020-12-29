import 'package:flutter/material.dart';
import 'package:flutter_markdown_editor/flutter_markdown_editor.dart';
import 'package:flutter_test/flutter_test.dart';

import 'testing_scaffold.dart';

void main() {
  testWidgets('test preview', (WidgetTester tester) async {
    final controller = TextEditingController();
    final linkText = 'link text';
    final linkUrl = 'https://example.com';
    final controllerText = '[$linkText]($linkUrl)';
    controller.text = controllerText;
    MarkDownEditor editor = MarkDownEditor(controller: controller);
    await tester.pumpWidget(
      TestingScaffold(
        child: editor.preview,
      ),
    );
    final textFinder = find.text(linkText);
    final urlFinder = find.text(linkUrl);
    expect(textFinder, findsOneWidget);
    expect(urlFinder, findsNothing);
  });
  testWidgets('test field', (WidgetTester tester) async {
    final controller = TextEditingController();
    final linkText = 'link text';
    final linkUrl = 'https://example.com';
    final controllerText = '[$linkText]($linkUrl)';
    controller.text = controllerText;
    MarkDownEditor editor = MarkDownEditor(controller: controller);
    await tester.pumpWidget(
      TestingScaffold(
        child: editor.field,
      ),
    );
    final textFinder = find.text(linkText);
    final urlFinder = find.text(linkUrl);
    final controllerFinder = find.text(controllerText);
    expect(textFinder, findsNothing);
    expect(urlFinder, findsNothing);
    expect(controllerFinder, findsOneWidget);
  });
}
