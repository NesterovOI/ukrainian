import 'package:shared_preferences/shared_preferences.dart';
import 'package:ukrainian/features/profile/domain/entities/settings_entity.dart';

const String keyTheme = 'keyTheme';
const String keyPush = 'keyPush';

class LocalStorageDataSource {
  Future<void> saveTheme(SettingsEntity value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyTheme, value.theme);
  }

  Future<void> savePush(SettingsEntity value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyPush, value.push);
  }

  Future<bool?> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isTheme = prefs.getBool(keyTheme);
    return isTheme;
  }

  Future<bool?> getPush() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isPush = prefs.getBool(keyPush);
    return isPush;
  }
}
