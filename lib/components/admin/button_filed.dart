import 'package:flutter/material.dart';

class ButtonField extends StatefulWidget {
  ButtonField(
      {super.key,
      required this.icon,
      required this.textField,
      required this.onTap});
  final Icon icon;
  final String textField;
  final Function onTap;
  @override
  State<ButtonField> createState() => _ButtonFliedState();
}

class _ButtonFliedState extends State<ButtonField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: ListTile(
        leading: Icon(
          widget.icon.icon,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        title: Text(
          widget.textField,
          style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        onTap: () {
          widget.onTap();
        },
      ),
    );
  }
}
