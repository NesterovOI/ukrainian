
abstract class AppStrings {
  //  ЗАГАЛЬНІ ЕЛЕМЕНТИ
  static const String appTitle = 'НМТ Експрес';
  static const String continueButton = 'ПРОДОВЖИТИ';
  static const String checkButton = 'ПЕРЕВІРИТИ';
  static const String nextLesson = 'НАСТУПНИЙ УРОК';

  // ДЛЯ РЕГІСТРАЦІЇ КОРИСТУВАЧА
  static const String signIn = 'УВІЙТИ';
  static const String register = 'РЕЄСТРАЦІЯ';
  static const String notHaveAccount = 'Ще не маєте акаунта?';
  static const String alreadyHaveAccount = 'Вже маєте акаунт?';
  static const String nameLabelText = 'Нікнейм';
  static const String nameHintText = 'alex_dev';
  static const String emailLabelText = 'Email';
  static const String emailHintText = 'example@email.com';
  static const String passwordLabelText = 'Пароль';
  static const String passwordLabelText2 = 'Підтвердити пароль';
  static const String passwordHintText = '******';
  static const String passwordMatch = 'Паролі не співпадають';
  static const String passwordShort = 'Мінімальна довжина пароля повинна бути 6 символів';
  static const String enterName = 'Введіть ваше ім\'я';
  static const String enterEmail = 'Введіть коректний Email';
  static const String sentLetterOnEmail = 'Лист із відновленням пароля надіслано на ваш Email!';
  static const String forgotPassword = 'Забули пароль?';
  static const String restorationPassword = 'Відновлення пароля';
  static const String enterYourEmail = 'Введіть ваш Email, і ми надішлемо інструкції для скидання пароля.';
  static const String enterYourEmailCorrect = 'Введіть ваш Email';
  static const String cancel = 'Скасувати';
  static const String send = 'Надіслати';
  static const String errorSharedPreferences = 'SharedPreferences не ініціалізовано';

  // ДЛЯ DICTIONARY
  static const String notHaveRule = 'Правил у цій категорії поки немає.';
  static const String searchRules = 'Пошук правил чи прикладів...';
  static const String errorDownloadDictionary = 'Помилка завантаження:';
  static const String ruleExamplesDictionary = '📌 Приклади:';
  static const String ruleExceptionsDictionary = '⚠️ Винятки (Зверни увагу на НМТ!):';

  // ДЛЯ HOME_LESSONS
  static const String defaultQuote = 'default';
  static const String textDefaultQuote = 'Мова — душа нації.';
  static const String authorDefaultQuote = 'Народна мудрість';
  static const String dayLabelHomeLessons = 'Днів';
  static const String pointsLabelHomeLessons = 'Бали';
  static const String livesLabelHomeLessons = 'Життя';
  static const String quoteDay = '💬 Цитата дня';
  static const String lessonProgram = 'Навчальна програма';

  //  ТЕСТИ ТА ГРА
  static const String correctAnswers = 'Чудово! Правильно';
  static const String wrongAnswer = 'Неправильно. Правильна відповідь:';
  static const String outOfLivesTitle = 'Ой, життя закінчилися!';
  static const String outOfLivesSub = 'Зачекай відновлення або подивись відео, щоб отримати +1 ❤️';
  static const String watchAdButton = 'Отримати життя за рекламу';

  //  НИЖНЯ ПАНЕЛЬ (Bottom Nav)
  static const String navHome = 'Головна';
  static const String navDictionary = 'Правила';
  static const String navLeaderboard = 'Рейтинг';
  static const String navProfile = 'Профіль';

  // ОБРОБКА ПОМИЛОК АВТОРИЗАЦІЇ
  static const String weakPassword = 'Пароль занадто простий (мінімум 6 символів).';
  static const String emailAlreadyInUse = 'Акаунт з цим Email вже існує.';
  static const String invalidEmail = 'Некоректна електронна адреса.';
  static const String invalidEmailOrPassword = 'Неправильний Email або пароль.';
  static const String invalidAuth = 'Помилка авторизації.';
  static const String invalidCreateUser = 'Не вдалося створити користувача.';
  static const String userNotFound = 'Користувача не знайдено.';
}