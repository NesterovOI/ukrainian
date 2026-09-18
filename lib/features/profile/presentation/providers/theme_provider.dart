import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/profile/domain/entities/settings_entity.dart';
import 'package:ukrainian/features/profile/domain/usecases/export_usecases.dart';
import 'package:ukrainian/features/profile/presentation/providers/riverpod_providers_di.dart';

class ThemeProvider extends AsyncNotifier<SettingsEntity> {
  late GetSettingsUseCase _getSettingsUseCase;
  late SaveSettingsUseCase _saveSettingsUseCase;

  @override
  Future<SettingsEntity> build() async {
    _getSettingsUseCase = ref.watch(getSettingsUseCase);
    _saveSettingsUseCase = ref.watch(saveSettingsUseCase);

    final settings = await _getSettingsUseCase();
    return settings ?? SettingsEntity(theme: false, push: false);
  }

  Future<void> toggleTheme(bool isDark) async {
    final currentSetting = state.value;
    if (currentSetting == null) return;

    final updateSettings = currentSetting.copyWith(theme: isDark);
    state = AsyncLoading<SettingsEntity>().copyWithPrevious(state);

    state = await AsyncValue.guard(() async {
      await _saveSettingsUseCase(updateSettings);
      return updateSettings;
    });
  }
}

final themeProvider = AsyncNotifierProvider<ThemeProvider, SettingsEntity>(
  () => ThemeProvider(),
);
