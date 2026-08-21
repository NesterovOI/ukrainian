import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class UserProgressTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get lives => integer().withDefault(const Constant(5))();
  IntColumn get score => integer().withDefault(const Constant(0))();
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
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
