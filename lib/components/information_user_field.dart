import 'package:flutter/material.dart';
import 'package:furniture_app/themes/theme_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InformationFields extends ConsumerWidget {
  final String text;
  final String? type;
  const InformationFields({super.key, this.type, required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    if (type == 'field') {
      return Container(
        decoration: BoxDecoration(
          color: appThemeState.isDarkModeEnabled
              ? const Color(0xff93b1a7)
              : const Color(0xff93b1a7),
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
        margin: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
        child: TextFormField(
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
            fontSize: 15,
          ),
        ),
      );
    }
  }
}
