import 'package:ukrainian/features/profile/domain/entities/settings_entity.dart';

class SettingsModel extends SettingsEntity {
  SettingsModel({required super.theme, required super.push});

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      theme: json['theme'] as bool? ?? false,
      push: json['push'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {'theme': theme, 'push': push};
}
