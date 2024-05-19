import 'package:flutter/material.dart';
import 'package:furniture_app/extension/buildcontext/loc.dart';
import 'package:furniture_app/pages/navigator_bar.dart';
import 'package:furniture_app/provider/region_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguagePage extends ConsumerWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    return Scaffold(
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
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false);
                    },
                    child: Container(
                      child: Text('${context.loc.english}'),
                    ),
                  ),
                ),
              ),
              if (locale.languageCode == 'en') Icon(Icons.check_circle),
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
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false);
                    },
                    child: Container(
                      child: Text('${context.loc.vietnamese}'),
                    ),
                  ),
                ),
              ),
              if (locale.languageCode == 'vi') Icon(Icons.check_circle),
            ]),
          ],
        ),
      ),
    );
  }
}
