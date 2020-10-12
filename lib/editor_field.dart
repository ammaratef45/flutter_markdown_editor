import 'package:flutter/material.dart';

class MrkdownEditingField extends StatelessWidget {
  const MrkdownEditingField({
    Key key,
    @required this.controller,
    this.onChange,
  }) : super(key: key);

  final TextEditingController controller;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      maxLines: 8,
      controller: controller,
      onChanged: (string) {
        onChange();
      },
    );
  }
}
