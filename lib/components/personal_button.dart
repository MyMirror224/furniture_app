import 'package:flutter/material.dart';
import 'package:furniture_app/themes/theme_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PersonalButton extends ConsumerWidget {
  final String text;
  final Function() onTap;
  final IconData icon;
  const PersonalButton(
      {super.key, required this.text, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(themeNotifierProvider);
   
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: appThemeState == ThemeMode.dark
            ? const Color(0xff93b1a7)
            : const Color(0xff93b1a7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: SizedBox(
        
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black45,
            ),
            const Gap(20),
            Text(text,
                style: const TextStyle(fontSize: 20, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
