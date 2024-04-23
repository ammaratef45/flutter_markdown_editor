import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

/// [MarkdownPreview] will use [Markdown] from [flutter_markdown]
/// to preview the markdown [text] passed to it.
///
/// [selectable] is used to determine if the preview will be
/// selectable or not and default to true.
class MarkdownPreview extends StatelessWidget {
  /// Create the [MarkdownPreview] passing the text and [selectable].
  const MarkdownPreview({
    Key? key,
    required this.text,
    this.selectable = true,
  }) : super(key: key);

  /// To be displayed by the [Markdown] widget.
  final String text;

  /// Whether should be selectable or not
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Markdown(
          controller: ScrollController(),
          selectable: selectable,
          onTapLink: (_, href, __) async {
            if (href == null || !await canLaunchUrl(Uri(path: href))) {
              Fluttertoast.showToast(
                msg: "Couldn't open the URL",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            } else {
              launchUrl(Uri(path: href));
            }
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
