import 'package:flutter/material.dart';
import 'package:furniture_app/services/constain.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
class MyWidget extends ConsumerWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    return GestureDetector(
      onTap: () {
       // ref.read(languageProvider.notifier).changeLanguage();
      },
      child: Container(
        child: Text('$vietnamese'),
      ),
    );
  }
}