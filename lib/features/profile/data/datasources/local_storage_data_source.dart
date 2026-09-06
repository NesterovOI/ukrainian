import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ukrainian/features/profile/domain/entities/settings_entity.dart';
import 'package:ukrainian/features/profile/data/models/settings_model.dart';

const String _keySettings = 'keySettings';

class LocalStorageDataSource {
  Future<bool> saveSettings(SettingsEntity settings) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final model = SettingsModel(theme: settings.theme, push: settings.push);
    final jsonString = jsonEncode(model.toJson());
    return await prefs.setString(_keySettings, jsonString);
  }

  Future<SettingsEntity?> getSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keySettings);
    if (jsonString == null) return null;

    final Map<String, dynamic> json = jsonDecode(jsonString);
    return SettingsModel.fromJson(json);
  }
}
