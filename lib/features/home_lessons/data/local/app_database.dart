import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class UserProgressTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userName => text().withDefault(const Constant('Учень'))();
  TextColumn get avatarPath => text().nullable()();
  BoolColumn get isPremium => boolean().withDefault(const Constant(false))();
  IntColumn get lives => integer().withDefault(const Constant(5))();
  IntColumn get score => integer().withDefault(const Constant(0))();
  IntColumn get streakDays => integer().withDefault(const Constant(0))();
  TextColumn get completedLessonIds =>
      text().withDefault(const Constant('[]'))();
  DateTimeColumn get lastActiveDate => dateTime().nullable()();
}

class QuestionHistoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get lessonId => text()();
  TextColumn get subcategoryId => text()();
  TextColumn get questionId => text()();
  BoolColumn get isCorrect => boolean()();
  DateTimeColumn get answeredAt => dateTime()();
}

@DriftDatabase(tables: [UserProgressTable, QuestionHistoryTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Отримати або створити початковий прогрес (ID = 1)
  Future<UserProgressTableData> getUserProgress() async {
    final progress = await (select(
      userProgressTable,
    )..where((tbl) => tbl.id.equals(1))).getSingleOrNull();
    if (progress != null) return progress;

    await into(userProgressTable).insert(
      UserProgressTableCompanion.insert(
        userName: const Value('Учень'),
        avatarPath: const Value(null),
        isPremium: const Value(false),
        lives: const Value(5),
        score: const Value(0),
        streakDays: const Value(0),
        completedLessonIds: const Value('[]'),
        lastActiveDate: const Value(null),
      ),
    );
    return getUserProgress();
  }

  // Оновити прогрес
  Future<void> updateUserProgress(UserProgressTableCompanion companion) async {
    await (update(
      userProgressTable,
    )..where((tbl) => tbl.id.equals(1))).write(companion);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
