import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_app/themes/theme_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InformationFields extends ConsumerWidget {
  late final String text;
  final String? type;
  final TextEditingController? controller;

  // ignore: prefer_const_constructors_in_immutables
  InformationFields(
      {super.key, required this.type, required this.text, this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(themeNotifierProvider);
    if (type == 'field') {
      return Container(
        decoration: BoxDecoration(
          color: appThemeState == ThemeMode.dark
              ? const Color(0xff93b1a7)
              : const Color(0xff93b1a7),
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
        margin: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
        child: TextFormField(
          onChanged: (value) => controller?.text = value,
          controller: controller,
          decoration: InputDecoration(
            hintText: text,
            hintStyle: const TextStyle(
              color: Colors.white54,
            ),
            border: InputBorder.none,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      );
    } else {
      return Container(
        alignment: Alignment.bottomLeft,
        margin: const EdgeInsets.only(left: 20),
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }
}

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();
    if (newTextLength >= 1) {
      newText.write('+');
      if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength >= 3) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 2) + ' ');
      if (newValue.selection.end >= 2) selectionIndex += 1;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

final _mobileFormatter = NumberTextInputFormatter();

class PhoneNumberFormatter extends TextInputFormatter {
  final phoneNumberRegExp = RegExp(r'^\d{10}$');
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;
    if (newText.length > 10) {
      return oldValue;
    }
    if (phoneNumberRegExp.hasMatch(newText)) {
      return newValue;
    }
    return oldValue;
  }
}
