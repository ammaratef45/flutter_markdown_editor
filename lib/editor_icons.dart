import 'package:flutter/material.dart';

typedef PromptFunction = Future<String?> Function();

/// A future function that can be used to prompt for a url or image source.
///
/// You can use this to show your own dialog and return the prompt value.
///
/// Check the function _takeInput for an example.
typedef UrlSource = Future<String> Function({
  @required BuildContext context,
  @required String hint,
  @required String label,
});

/// A row of icons(buttons) that can be used to manipulate the text.
///
/// It manipulates the text inside the [controller].
///
/// The function [afterEditing] will be called after the text is edited.
///
/// The [urlSource] is afuture function that can be used to prompt
/// for a url or image source, You can use it to show your
/// own dialog and return the prompt value, Check the
/// function _takeInput for an example.
// ignore: must_be_immutable
class MarkdownEditorIcons extends StatelessWidget {
  /// Create a [MarkdownEditorIcons] passing a [controller],
  /// [urlSource] and [afterEditing].
  MarkdownEditorIcons({
    Key? key,
    required this.controller,
    this.afterEditing,
    this.urlSource,
  }) : super(key: key) {
    controller.selection = _lastValidSelection;
    controller.addListener(() {
      if (controller.selection.isValid) {
        _lastValidSelection = controller.selection;
      }
    });
  }

  final _scrollbarController = ScrollController();
  TextSelection _lastValidSelection = TextSelection.collapsed(offset: 0);

  /// This widget will manipulate the text inside this [controller].
  final TextEditingController controller;

  /// Will be invoked afer editing the text.
  final Function? afterEditing;

  /// A future function that can be used to prompt for a url or image source.
  ///
  /// You can use this to show your own dialog and return the prompt value.
  ///
  /// Check the function _takeInput for an example.
  final UrlSource? urlSource;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Scrollbar(
        controller: _scrollbarController,
        thumbVisibility: true,
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
                onPressed: () {
                  _surroundTextSelection(
                    '[',
                    '](',
                    prompt: _getPromptFunction(
                      context: context,
                      hint: 'https://',
                      label: 'URL',
                    ),
                    afterPrompt: ')',
                  );
                }),
            IconButton(
              tooltip: 'Image',
              icon: Icon(Icons.image),
              onPressed: () => _surroundTextSelection(
                '![',
                '](',
                prompt: _getPromptFunction(
                  context: context,
                  hint: 'https://',
                  label: 'Source',
                ),
                afterPrompt: ')',
              ),
            ),
          ],
        ),
      ),
    );
  }

  PromptFunction _getPromptFunction({
    required String label,
    required String hint,
    required BuildContext context,
  }) {
    return () {
      return urlSource == null
          ? _takeInput(context: context, hint: hint, label: label)
          : urlSource!(context: context, hint: hint, label: label);
    };
  }

  void _surroundTextSelection(
    String left,
    String right, {
    PromptFunction? prompt,
    String? afterPrompt,
  }) async {
    final currentTextValue = controller.value.text;
    final selection = _lastValidSelection;
    final middle = selection.textInside(currentTextValue);
    final textBefore = selection.textBefore(currentTextValue);
    final textAfter = selection.textAfter(currentTextValue);
    String insertion = '$left$middle$right';
    if (prompt != null) {
      assert(afterPrompt != null);
      insertion += await prompt() ?? '';
      insertion += afterPrompt!;
    }

    final newTextValue = '$textBefore$insertion$textAfter';

    controller.value = controller.value.copyWith(
      text: newTextValue,
      selection: TextSelection.collapsed(
        offset: selection.baseOffset + left.length + middle.length,
      ),
    );
    if (afterEditing != null) afterEditing!.call();
  }

  Future<String?> _takeInput({
    required BuildContext context,
    required String hint,
    required String label,
  }) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return _InputPrompt(
          title: 'Enter the value!',
          hint: hint,
          label: label,
        );
      },
    );
  }
}

class _InputPrompt extends StatelessWidget {
  final String title;
  final String label;
  final String hint;

  final _controller = TextEditingController();

  _InputPrompt({
    Key? key,
    required this.title,
    required this.label,
    required this.hint,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(title),
      children: [
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop<String>(context, _controller.text);
          },
          child: Text('Done'),
        ),
      ],
    );
  }
}
