import 'package:flutter/material.dart';

// TODO add emoji selector to the editor
class MarkdownEditorIcons extends StatelessWidget {
  final _scrollbarController = ScrollController();
  final TextEditingController controller;
  final Function afterEditing;

  MarkdownEditorIcons({Key key, @required this.controller, this.afterEditing})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Scrollbar(
        controller: _scrollbarController,
        isAlwaysShown: true,
        child: ListView(
          controller: _scrollbarController,
          scrollDirection: Axis.horizontal,
          children: [
            IconButton(
              tooltip: 'Bold',
              icon: Icon(Icons.format_bold),
              onPressed: () => _surroundTextSelection(
                '**',
                '**',
              ),
            ),
            IconButton(
              tooltip: 'Underline',
              icon: Icon(Icons.format_italic),
              onPressed: () => _surroundTextSelection(
                '__',
                '__',
              ),
            ),
            IconButton(
              tooltip: 'Code',
              icon: Icon(Icons.code),
              onPressed: () => _surroundTextSelection(
                '```',
                '```',
              ),
            ),
            IconButton(
              tooltip: 'Strikethrough',
              icon: Icon(Icons.strikethrough_s_rounded),
              onPressed: () => _surroundTextSelection(
                '~~',
                '~~',
              ),
            ),
            IconButton(
              tooltip: 'Link',
              icon: Icon(Icons.link_sharp),
              onPressed: () => _surroundTextSelection(
                '[',
                '](https://)',
              ),
            ),
            IconButton(
              tooltip: 'Image',
              icon: Icon(Icons.image),
              onPressed: () => _surroundTextSelection(
                '![',
                '](https://)',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _surroundTextSelection(String left, String right) {
    final currentTextValue = controller.value.text;
    final selection = controller.selection;
    final middle = selection.textInside(currentTextValue);
    final newTextValue = selection.textBefore(currentTextValue) +
        '$left$middle$right' +
        selection.textAfter(currentTextValue);

    controller.value = controller.value.copyWith(
      text: newTextValue,
      selection: TextSelection.collapsed(
        offset: selection.baseOffset + left.length + middle.length,
      ),
    );
    if (afterEditing != null) afterEditing();
  }
}
