library flutter_markdown_editor;

import 'package:flutter/material.dart';
import 'package:flutter_markdown_editor/editor_field.dart';
import 'package:flutter_markdown_editor/editor_icons.dart';
import 'package:flutter_markdown_editor/editor_preview.dart';

/// A Markdown Editor class.
class MarkDownEditor {
  /// Controller for the text.
  TextEditingController _controller;

  Widget _field;
  Widget _icons;
  Widget _preview;
  Function _setStateFuntion;

  /// Ctor.
  MarkDownEditor({TextEditingController controller})
      : _controller = controller {
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

  Widget get field => _field;
  Widget get icons => _icons;
  Widget get preview => _preview;

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
