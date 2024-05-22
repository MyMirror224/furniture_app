import 'package:flutter/material.dart';
import 'package:furniture_app/extension/buildcontext/loc.dart';
import 'package:furniture_app/provider/region_provider.dart';
import 'package:furniture_app/state/auth/auth_state_provider.dart';
import 'package:furniture_app/themes/theme_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguagePage extends ConsumerWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    final locale = ref.watch(localeProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff193d3d),
        title: Text(context.loc.language),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      ref
                          .read(localeProvider.notifier)
                          .setLocale(Locale('en', 'US'));
                      return ref.refresh(authStateProvider.notifier);
                    },
                    child: Container(
                      child: Text('${context.loc.english}'),
                    ),
                  ),
                ),
              ),
              if (locale.languageCode == 'en')
                Icon(Icons.check_circle,
                    color: themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black),
            ]),
            Row(children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      ref
                          .read(localeProvider.notifier)
                          .setLocale(Locale('vi', 'VN'));
                      return ref.refresh(authStateProvider.notifier);
                    },
                    child: Container(
                      child: Text('${context.loc.vietnamese}'),
                    ),
                  ),
                ),
              ),
              if (locale.languageCode == 'vi')
                Icon(Icons.check_circle,
                    color: themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black),
            ]),
          ],
        ),
      ),
    );
  }
}
