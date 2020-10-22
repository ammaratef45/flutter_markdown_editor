import 'package:flutter/material.dart';

/// A row of icons(buttons) that can be used to manipulate the text.
///
/// It manipulates the text inside the [controller].
///
/// The function [afterEditing] will be called after the text is edited.
class MarkdownEditorIcons extends StatelessWidget {
  /// Create a [MarkdownEditorIcons] passing a [controller] and [afterEditing].
  MarkdownEditorIcons({
    Key key,
    @required this.controller,
    this.afterEditing,
  })  : assert(controller != null),
        super(key: key);

  final _scrollbarController = ScrollController();

  /// This widget will manipulate the text inside this [controller].
  final TextEditingController controller;

  /// Will be invoked afer editing the text.
  final Function afterEditing;

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
