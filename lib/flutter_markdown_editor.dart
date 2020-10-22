library flutter_markdown_editor;

import 'package:flutter/material.dart';
import 'package:flutter_markdown_editor/editor_field.dart';
import 'package:flutter_markdown_editor/editor_icons.dart';
import 'package:flutter_markdown_editor/editor_preview.dart';

/// A [MarkDownEditor] class that encapsulates the widgets needed
/// for markdwon editing.
///
/// [field] is the [MrkdownEditingField] widget.
///
/// [icons] is the [MarkdownEditorIcons] widget.
///
/// [preview] is the [MarkdownPreview] widget (wrapped in [StatefulBuilder]).
///
/// [vertical] is a widget that encapsulates the [field], [icons], and
/// [preview] in a column.
///
/// [inPlace] is a widget that shows only [filed] or [preview] and a switch
/// to switch between them.
class MarkDownEditor {
  /// Create a [MarkDownEditor] using a passed [controller] or
  /// create one if null.
  ///
  /// Initializes the widgets [MrkdownEditingField], [MarkdownEditorIcons] and
  /// [MarkdownPreview] passing the [controller] or its [text] and all other
  /// necessary parameters.
  MarkDownEditor({
    TextEditingController controller,
  }) : _controller = controller {
    if (_controller == null) _controller = TextEditingController();
    _field = MrkdownEditingField(
      controller: _controller,
      key: UniqueKey(),
      onChange: _setState,
    );
    _icons = MarkdownEditorIcons(
      controller: _controller,
      key: UniqueKey(),
      afterEditing: _setState,
    );
    _preview = StatefulBuilder(
      builder: (context, setState) {
        _setStateFuntion = setState;
        return MarkdownPreview(
          text: _controller.text,
          key: UniqueKey(),
        );
      },
    );
  }

  TextEditingController _controller;
  Widget _field;
  Widget _icons;
  Widget _preview;
  Function _setStateFuntion;

  /// [field] is the [MrkdownEditingField] widget.
  Widget get field => _field;

  /// [icons] is the [MarkdownEditorIcons] widget.
  Widget get icons => _icons;

  /// [preview] is the [MarkdownPreview] widget (wrapped in [StatefulBuilder]).
  Widget get preview => _preview;

  /// [vertical] is a widget that encapsulates the [field], [icons], and
  /// [preview] in a column.
  Widget vertical() {
    return Column(
      children: [
        field,
        icons,
        Flexible(
          child: preview,
        ),
      ],
    );
  }

  /// [inPlace] is a widget that shows only [filed] or [preview] and a switch
  /// to switch between them.
  Widget inPlace() {
    bool isPreviewing = false;
    return StatefulBuilder(builder: (context, setstate) {
      return Column(
        children: [
          Switch(
            value: isPreviewing,
            onChanged: (val) {
              setstate(() {
                isPreviewing = val;
              });
            },
          ),
          Stack(
            children: [
              if (!isPreviewing)
                Column(
                  children: [
                    field,
                    icons,
                  ],
                ),
              if (isPreviewing) preview,
            ],
          ),
        ],
      );
    });
  }

  void _setState() {
    _setStateFuntion(() {});
  }
}
