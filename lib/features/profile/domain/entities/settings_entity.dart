class SettingsEntity {
  final bool theme;
  final bool push;
  final int reminderHour;
  final int reminderMinute;

  SettingsEntity({
    required this.theme,
    required this.push,
    this.reminderHour = 19,
    this.reminderMinute = 0,
  });

  SettingsEntity copyWith({
    bool? theme,
    bool? push,
    int? reminderHour,
    int? reminderMinute,
  }) {
    return SettingsEntity(
      theme: theme ?? this.theme,
      push: push ?? this.push,
      reminderHour: reminderHour ?? this.reminderHour,
      reminderMinute: reminderMinute ?? this.reminderMinute,
    );
  }
}
