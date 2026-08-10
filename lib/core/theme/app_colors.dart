import 'package:flutter/material.dart';

abstract class AppColors {
  //  СВІТЛА ТЕМА (Light Theme)
  static const Color lightBackground = Color(0xFFF8FAFC); // М'який біло-сірий (фон екранів)
  static const Color lightSurface = Color(0xFFFFFFFF);    // Чисто білий (для картки, списків, поп-апів)
  static const Color lightTextPrimary = Color(0xFF0F172A); // Глибокий графітовий (основни текст, правила)
  static const Color lightTextSecondary = Color(0xFF64748B); // М'який сірий (підказки, пояснення)
  static const Color lightBorder = Color(0xFFE2E8F0);    // Світла рамка картки/списку

  //  ТЕМНА ТЕМА (Dark Theme)
  static const Color darkBackground = Color(0xFF0F172A);  // Глибокий нічний сіро-синій
  static const Color darkSurface = Color(0xFF1E293B);     // Темно-аквамаринова картка
  static const Color darkTextPrimary = Color(0xFFF8FAFC);  // Майже білий текст
  static const Color darkTextSecondary = Color(0xFF94A3B8); // Світло-сірий текст
  static const Color darkBorder = Color(0xFF334155);     // Темно-сіра рамка

  //  АКЦЕНТНІ ТА ГЕЙМІФІКОВАНІ КОЛЬОРИ (Активні в обох темах)
  // 1. Головний колір (Активні кнопки, прогрес-бари)
  static const Color primary = Color(0xFFFACC15);         // Насичений лимонно-жовтий
  static const Color primaryShadow = Color(0xFFCA8A04);   // 3D-грань для жовтої кнопки

  // 2. Колір успіху / Правильної відповіді
  static const Color success = Color(0xFF10B981);         // Смарагдово-зелений
  static const Color successShadow = Color(0xFF047857);   // 3D-грань для зеленої кнопки

  // 3. Колір помилки / Життів (Сердечка ❤️)
  static const Color error = Color(0xFFEF4444);           // Соковитий червоний
  static const Color errorShadow = Color(0xFFB91C1C);     // 3D-грань для червоної кнопки

  // 4. Колір безперервних днів використання
  static const Color streakDays = Color(0xFFF68616);

  // 5. Неактивний стан (Disabled)
  static const Color disabled = Color(0xFFCBD5E1);
  static const Color disabledShadow = Color(0xFF94A3B8);
}