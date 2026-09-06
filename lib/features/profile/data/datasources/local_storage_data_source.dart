import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ukrainian/features/profile/domain/entities/settings_entity.dart';
import 'package:ukrainian/features/profile/data/models/settings_model.dart';

const String _keyTheme = 'keyTheme';
const String _keyPush = 'keyPush';

class LocalStorageDataSource {
  Future<bool> saveTheme(SettingsEntity value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final model = SettingsModel(theme: value.theme, push: value.push);
    final jsonString = jsonEncode(model.toJson());
    return await prefs.setString(_keyTheme, jsonString);
  }

  Future<bool> savePush(SettingsEntity value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final model = SettingsModel(theme: value.theme, push: value.push);
    final jsonString = jsonEncode(model.toJson());
    return await prefs.setString(_keyPush, jsonString);
  }

  Future<SettingsEntity?> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyTheme);
    if (jsonString == null) return null;

    final Map<String, dynamic> json = jsonDecode(jsonString);
    return SettingsModel.fromJson(json);
  }

  Future<SettingsEntity?> getPush() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyPush);
    if (jsonString == null) return null;

    final Map<String, dynamic> json = jsonDecode(jsonString);
    return SettingsModel.fromJson(json);
  }
}
