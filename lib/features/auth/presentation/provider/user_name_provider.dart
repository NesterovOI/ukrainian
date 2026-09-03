import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/core/provider/shared_preferences_provider.dart';

const String kUserNameKey = 'user_name';
final userNameProvider = NotifierProvider<UserNameNotifier, String>(
  UserNameNotifier.new,
);

class UserNameNotifier extends Notifier<String> {
  @override
  String build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getString(kUserNameKey) ?? '';
  }

  Future<void> setUserName(String name) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(kUserNameKey, name);
    state = name;
  }

  Future<void> clearUserName() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.remove(kUserNameKey);
    state = '';
  }
}
