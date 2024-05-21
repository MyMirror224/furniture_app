import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(Locale('en', 'US')) {
    init();
  } // Đặt giá trị mặc định là 'en'
  late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final languageCode = _sharedPreferences.getString('languageCode') ?? 'en';
    state = Locale(languageCode);
  }

  Future<void> setLocale(Locale locale) async {
    if (!supportedLocales.contains(locale)) return;

    state = locale;

    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString('languageCode', locale.languageCode);
  }

  static final List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
    // Thêm các ngôn ngữ khác nếu cần
  ];
}
