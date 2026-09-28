/// Сервіс розрахунку балів НМТ за актуальною таблицею переведення УЦОЯО
///
class NmtScoreCalculator {
  static const Map<int, int> _conversionTable = {
    0: 0,
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 100,
    6: 106,
    7: 112,
    8: 118,
    9: 124,
    10: 129,
    11: 134,
    12: 138,
    13: 142,
    14: 145,
    15: 148,
    16: 151,
    17: 154,
    18: 157,
    19: 160,
    20: 162,
    21: 164,
    22: 166,
    23: 168,
    24: 170,
    25: 172,
    26: 174,
    27: 176,
    28: 178,
    29: 180,
    30: 182,
    31: 184,
    32: 186,
    33: 188,
    34: 190,
    35: 191,
    36: 192,
    37: 193,
    38: 194,
    39: 195,
    40: 196,
    41: 197,
    42: 198,
    43: 199,
    44: 199,
    45: 200,
  };

  /// Переводить тестовий бал (0..45) у підсумковий бал НМТ (100..200)
  static int calculateNMTScore(int rawScore) {
    if (rawScore <= 0) return 0;
    if (rawScore >= 45) return 200;
    return _conversionTable[rawScore] ?? 100;
  }

  /// Перевіряє, чи складено іспит (поріг 100+ балів)
  static bool isPassed(int nmtScore) {
    return nmtScore >= 100;
  }

  /// Визначає, чи заслуговує користувач на супер-бонус (відновлення всіх життів)
  static bool qualifiesForLifeRestoration(int nmtScore) {
    return nmtScore >= 140;
  }
}
