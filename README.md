
A flutter package for a readme editor.

[![pub](https://img.shields.io/pub/v/flutter_markdown_editor.svg)](https://pub.dev/packages/flutter_markdown_editor)

<!-- todo add build and codecoverage badges -->

# Usage
Add dev dependency to your `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_markdown_editor: ^0.0.1
```

Run `flutter pub get` to install.

# How it works
<!-- todo add screenshpts -->
Import
```Dart
import 'package:stack/stack.dart';
```
Initialize
```Dart
TextEditingController controller = TextEditingController();
final MarkDownEditor markDownEditor = MarkDownEditor(controller: controller);
```
Vertical
```Dart
markDownEditor.vertical()
```
In place
```Dart
markDownEditor.inPlace()
```
Access widget pieces for a custom view
```Dart
markDownEditor.field // to get the editing filed
markDownEditor.preview // to get the preview widget
markDownEditor.icons // to get the editing icons (buttons)
```
