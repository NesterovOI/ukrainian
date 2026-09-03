import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeProvider extends StateNotifier<ThemeMode> {
  ThemeProvider() : super(ThemeMode.light);

  void setTheme(ThemeMode? mode) {
    if (mode == ThemeMode.system) {
      state = ThemeMode.system;
    } else if (mode == ThemeMode.light) {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.dark;
    }
  }

  void toggleTheme() {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
  }
}

final themeProvider = StateNotifierProvider<ThemeProvider, ThemeMode>((ref) {
  return ThemeProvider();
});
