
A flutter package for a readme editor.

[![pub](https://img.shields.io/pub/v/flutter_markdown_editor.svg)](https://pub.dev/packages/flutter_markdown_editor)
[![build](https://api.codemagic.io/apps/5f8ba9e48927e94619c42d6f/default/status_badge.svg)](https://codemagic.io/app/5f8ba9e48927e94619c42d6f)
[![codecov](https://codecov.io/gh/ammaratef45/flutter_markdown_editor/branch/main/graph/badge.svg)](https://codecov.io/gh/ammaratef45/flutter_markdown_editor)

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
