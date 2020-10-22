import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

/// [MarkdownPreview] will use [Markdown] from [flutter_markdown]
/// to preview the markdown [text] passed to it.
class MarkdownPreview extends StatelessWidget {
  /// Create the [MarkdownPreview] passing the text.
  const MarkdownPreview({
    Key key,
    @required this.text,
  }) : super(key: key);

  /// To be displayed by the [Markdown] widget.
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Markdown(
          controller: ScrollController(),
          onTapLink: (_, href, __) {
            canLaunch(href).then((value) {
              if (value) {
                launch(href);
              } else {
                Fluttertoast.showToast(
                  msg: "Couldn't open the URL",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            });
          },
          data: text,
          shrinkWrap: true,
          extensionSet: md.ExtensionSet(
            md.ExtensionSet.gitHubFlavored.blockSyntaxes,
            [
              md.EmojiSyntax(),
              ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
            ],
          ),
        ),
      ),
    );
  }
}
