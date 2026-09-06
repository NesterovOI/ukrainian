class SettingsEntity {
  final bool theme;
  final bool push;

  SettingsEntity({required this.theme, required this.push});

  SettingsEntity copyWith({bool? theme, bool? push}) {
    return SettingsEntity(theme: theme ?? this.theme, push: push ?? this.push);
  }
}
