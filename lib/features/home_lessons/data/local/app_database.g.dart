// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserProgressTableTable extends UserProgressTable
    with TableInfo<$UserProgressTableTable, UserProgressTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProgressTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userNameMeta = const VerificationMeta(
    'userName',
  );
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
    'user_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Учень'),
  );
  static const VerificationMeta _avatarPathMeta = const VerificationMeta(
    'avatarPath',
  );
  @override
  late final GeneratedColumn<String> avatarPath = GeneratedColumn<String>(
    'avatar_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPremiumMeta = const VerificationMeta(
    'isPremium',
  );
  @override
  late final GeneratedColumn<bool> isPremium = GeneratedColumn<bool>(
    'is_premium',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_premium" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _livesMeta = const VerificationMeta('lives');
  @override
  late final GeneratedColumn<int> lives = GeneratedColumn<int>(
    'lives',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _streakDaysMeta = const VerificationMeta(
    'streakDays',
  );
  @override
  late final GeneratedColumn<int> streakDays = GeneratedColumn<int>(
    'streak_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _completedLessonIdsMeta =
      const VerificationMeta('completedLessonIds');
  @override
  late final GeneratedColumn<String> completedLessonIds =
      GeneratedColumn<String>(
        'completed_lesson_ids',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _lastActiveDateMeta = const VerificationMeta(
    'lastActiveDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastActiveDate =
      GeneratedColumn<DateTime>(
        'last_active_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userName,
    avatarPath,
    isPremium,
    lives,
    score,
    streakDays,
    completedLessonIds,
    lastActiveDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_progress_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProgressTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_name')) {
      context.handle(
        _userNameMeta,
        userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta),
      );
    }
    if (data.containsKey('avatar_path')) {
      context.handle(
        _avatarPathMeta,
        avatarPath.isAcceptableOrUnknown(data['avatar_path']!, _avatarPathMeta),
      );
    }
    if (data.containsKey('is_premium')) {
      context.handle(
        _isPremiumMeta,
        isPremium.isAcceptableOrUnknown(data['is_premium']!, _isPremiumMeta),
      );
    }
    if (data.containsKey('lives')) {
      context.handle(
        _livesMeta,
        lives.isAcceptableOrUnknown(data['lives']!, _livesMeta),
      );
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    }
    if (data.containsKey('streak_days')) {
      context.handle(
        _streakDaysMeta,
        streakDays.isAcceptableOrUnknown(data['streak_days']!, _streakDaysMeta),
      );
    }
    if (data.containsKey('completed_lesson_ids')) {
      context.handle(
        _completedLessonIdsMeta,
        completedLessonIds.isAcceptableOrUnknown(
          data['completed_lesson_ids']!,
          _completedLessonIdsMeta,
        ),
      );
    }
    if (data.containsKey('last_active_date')) {
      context.handle(
        _lastActiveDateMeta,
        lastActiveDate.isAcceptableOrUnknown(
          data['last_active_date']!,
          _lastActiveDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProgressTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProgressTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_name'],
      )!,
      avatarPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_path'],
      ),
      isPremium: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_premium'],
      )!,
      lives: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lives'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
      streakDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}streak_days'],
      )!,
      completedLessonIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}completed_lesson_ids'],
      )!,
      lastActiveDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_active_date'],
      ),
    );
  }

  @override
  $UserProgressTableTable createAlias(String alias) {
    return $UserProgressTableTable(attachedDatabase, alias);
  }
}

class UserProgressTableData extends DataClass
    implements Insertable<UserProgressTableData> {
  final int id;
  final String userName;
  final String? avatarPath;
  final bool isPremium;
  final int lives;
  final int score;
  final int streakDays;
  final String completedLessonIds;
  final DateTime? lastActiveDate;
  const UserProgressTableData({
    required this.id,
    required this.userName,
    this.avatarPath,
    required this.isPremium,
    required this.lives,
    required this.score,
    required this.streakDays,
    required this.completedLessonIds,
    this.lastActiveDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_name'] = Variable<String>(userName);
    if (!nullToAbsent || avatarPath != null) {
      map['avatar_path'] = Variable<String>(avatarPath);
    }
    map['is_premium'] = Variable<bool>(isPremium);
    map['lives'] = Variable<int>(lives);
    map['score'] = Variable<int>(score);
    map['streak_days'] = Variable<int>(streakDays);
    map['completed_lesson_ids'] = Variable<String>(completedLessonIds);
    if (!nullToAbsent || lastActiveDate != null) {
      map['last_active_date'] = Variable<DateTime>(lastActiveDate);
    }
    return map;
  }

  UserProgressTableCompanion toCompanion(bool nullToAbsent) {
    return UserProgressTableCompanion(
      id: Value(id),
      userName: Value(userName),
      avatarPath: avatarPath == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarPath),
      isPremium: Value(isPremium),
      lives: Value(lives),
      score: Value(score),
      streakDays: Value(streakDays),
      completedLessonIds: Value(completedLessonIds),
      lastActiveDate: lastActiveDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastActiveDate),
    );
  }

  factory UserProgressTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProgressTableData(
      id: serializer.fromJson<int>(json['id']),
      userName: serializer.fromJson<String>(json['userName']),
      avatarPath: serializer.fromJson<String?>(json['avatarPath']),
      isPremium: serializer.fromJson<bool>(json['isPremium']),
      lives: serializer.fromJson<int>(json['lives']),
      score: serializer.fromJson<int>(json['score']),
      streakDays: serializer.fromJson<int>(json['streakDays']),
      completedLessonIds: serializer.fromJson<String>(
        json['completedLessonIds'],
      ),
      lastActiveDate: serializer.fromJson<DateTime?>(json['lastActiveDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userName': serializer.toJson<String>(userName),
      'avatarPath': serializer.toJson<String?>(avatarPath),
      'isPremium': serializer.toJson<bool>(isPremium),
      'lives': serializer.toJson<int>(lives),
      'score': serializer.toJson<int>(score),
      'streakDays': serializer.toJson<int>(streakDays),
      'completedLessonIds': serializer.toJson<String>(completedLessonIds),
      'lastActiveDate': serializer.toJson<DateTime?>(lastActiveDate),
    };
  }

  UserProgressTableData copyWith({
    int? id,
    String? userName,
    Value<String?> avatarPath = const Value.absent(),
    bool? isPremium,
    int? lives,
    int? score,
    int? streakDays,
    String? completedLessonIds,
    Value<DateTime?> lastActiveDate = const Value.absent(),
  }) => UserProgressTableData(
    id: id ?? this.id,
    userName: userName ?? this.userName,
    avatarPath: avatarPath.present ? avatarPath.value : this.avatarPath,
    isPremium: isPremium ?? this.isPremium,
    lives: lives ?? this.lives,
    score: score ?? this.score,
    streakDays: streakDays ?? this.streakDays,
    completedLessonIds: completedLessonIds ?? this.completedLessonIds,
    lastActiveDate: lastActiveDate.present
        ? lastActiveDate.value
        : this.lastActiveDate,
  );
  UserProgressTableData copyWithCompanion(UserProgressTableCompanion data) {
    return UserProgressTableData(
      id: data.id.present ? data.id.value : this.id,
      userName: data.userName.present ? data.userName.value : this.userName,
      avatarPath: data.avatarPath.present
          ? data.avatarPath.value
          : this.avatarPath,
      isPremium: data.isPremium.present ? data.isPremium.value : this.isPremium,
      lives: data.lives.present ? data.lives.value : this.lives,
      score: data.score.present ? data.score.value : this.score,
      streakDays: data.streakDays.present
          ? data.streakDays.value
          : this.streakDays,
      completedLessonIds: data.completedLessonIds.present
          ? data.completedLessonIds.value
          : this.completedLessonIds,
      lastActiveDate: data.lastActiveDate.present
          ? data.lastActiveDate.value
          : this.lastActiveDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProgressTableData(')
          ..write('id: $id, ')
          ..write('userName: $userName, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('isPremium: $isPremium, ')
          ..write('lives: $lives, ')
          ..write('score: $score, ')
          ..write('streakDays: $streakDays, ')
          ..write('completedLessonIds: $completedLessonIds, ')
          ..write('lastActiveDate: $lastActiveDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userName,
    avatarPath,
    isPremium,
    lives,
    score,
    streakDays,
    completedLessonIds,
    lastActiveDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProgressTableData &&
          other.id == this.id &&
          other.userName == this.userName &&
          other.avatarPath == this.avatarPath &&
          other.isPremium == this.isPremium &&
          other.lives == this.lives &&
          other.score == this.score &&
          other.streakDays == this.streakDays &&
          other.completedLessonIds == this.completedLessonIds &&
          other.lastActiveDate == this.lastActiveDate);
}

class UserProgressTableCompanion
    extends UpdateCompanion<UserProgressTableData> {
  final Value<int> id;
  final Value<String> userName;
  final Value<String?> avatarPath;
  final Value<bool> isPremium;
  final Value<int> lives;
  final Value<int> score;
  final Value<int> streakDays;
  final Value<String> completedLessonIds;
  final Value<DateTime?> lastActiveDate;
  const UserProgressTableCompanion({
    this.id = const Value.absent(),
    this.userName = const Value.absent(),
    this.avatarPath = const Value.absent(),
    this.isPremium = const Value.absent(),
    this.lives = const Value.absent(),
    this.score = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.completedLessonIds = const Value.absent(),
    this.lastActiveDate = const Value.absent(),
  });
  UserProgressTableCompanion.insert({
    this.id = const Value.absent(),
    this.userName = const Value.absent(),
    this.avatarPath = const Value.absent(),
    this.isPremium = const Value.absent(),
    this.lives = const Value.absent(),
    this.score = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.completedLessonIds = const Value.absent(),
    this.lastActiveDate = const Value.absent(),
  });
  static Insertable<UserProgressTableData> custom({
    Expression<int>? id,
    Expression<String>? userName,
    Expression<String>? avatarPath,
    Expression<bool>? isPremium,
    Expression<int>? lives,
    Expression<int>? score,
    Expression<int>? streakDays,
    Expression<String>? completedLessonIds,
    Expression<DateTime>? lastActiveDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userName != null) 'user_name': userName,
      if (avatarPath != null) 'avatar_path': avatarPath,
      if (isPremium != null) 'is_premium': isPremium,
      if (lives != null) 'lives': lives,
      if (score != null) 'score': score,
      if (streakDays != null) 'streak_days': streakDays,
      if (completedLessonIds != null)
        'completed_lesson_ids': completedLessonIds,
      if (lastActiveDate != null) 'last_active_date': lastActiveDate,
    });
  }

  UserProgressTableCompanion copyWith({
    Value<int>? id,
    Value<String>? userName,
    Value<String?>? avatarPath,
    Value<bool>? isPremium,
    Value<int>? lives,
    Value<int>? score,
    Value<int>? streakDays,
    Value<String>? completedLessonIds,
    Value<DateTime?>? lastActiveDate,
  }) {
    return UserProgressTableCompanion(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      avatarPath: avatarPath ?? this.avatarPath,
      isPremium: isPremium ?? this.isPremium,
      lives: lives ?? this.lives,
      score: score ?? this.score,
      streakDays: streakDays ?? this.streakDays,
      completedLessonIds: completedLessonIds ?? this.completedLessonIds,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (avatarPath.present) {
      map['avatar_path'] = Variable<String>(avatarPath.value);
    }
    if (isPremium.present) {
      map['is_premium'] = Variable<bool>(isPremium.value);
    }
    if (lives.present) {
      map['lives'] = Variable<int>(lives.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (streakDays.present) {
      map['streak_days'] = Variable<int>(streakDays.value);
    }
    if (completedLessonIds.present) {
      map['completed_lesson_ids'] = Variable<String>(completedLessonIds.value);
    }
    if (lastActiveDate.present) {
      map['last_active_date'] = Variable<DateTime>(lastActiveDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProgressTableCompanion(')
          ..write('id: $id, ')
          ..write('userName: $userName, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('isPremium: $isPremium, ')
          ..write('lives: $lives, ')
          ..write('score: $score, ')
          ..write('streakDays: $streakDays, ')
          ..write('completedLessonIds: $completedLessonIds, ')
          ..write('lastActiveDate: $lastActiveDate')
          ..write(')'))
        .toString();
  }
}

class $QuestionHistoryTableTable extends QuestionHistoryTable
    with TableInfo<$QuestionHistoryTableTable, QuestionHistoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionHistoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _lessonIdMeta = const VerificationMeta(
    'lessonId',
  );
  @override
  late final GeneratedColumn<String> lessonId = GeneratedColumn<String>(
    'lesson_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subcategoryIdMeta = const VerificationMeta(
    'subcategoryId',
  );
  @override
  late final GeneratedColumn<String> subcategoryId = GeneratedColumn<String>(
    'subcategory_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCorrectMeta = const VerificationMeta(
    'isCorrect',
  );
  @override
  late final GeneratedColumn<bool> isCorrect = GeneratedColumn<bool>(
    'is_correct',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_correct" IN (0, 1))',
    ),
  );
  static const VerificationMeta _answeredAtMeta = const VerificationMeta(
    'answeredAt',
  );
  @override
  late final GeneratedColumn<DateTime> answeredAt = GeneratedColumn<DateTime>(
    'answered_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lessonId,
    subcategoryId,
    questionId,
    isCorrect,
    answeredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_history_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionHistoryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lesson_id')) {
      context.handle(
        _lessonIdMeta,
        lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('subcategory_id')) {
      context.handle(
        _subcategoryIdMeta,
        subcategoryId.isAcceptableOrUnknown(
          data['subcategory_id']!,
          _subcategoryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subcategoryIdMeta);
    }
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('is_correct')) {
      context.handle(
        _isCorrectMeta,
        isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta),
      );
    } else if (isInserting) {
      context.missing(_isCorrectMeta);
    }
    if (data.containsKey('answered_at')) {
      context.handle(
        _answeredAtMeta,
        answeredAt.isAcceptableOrUnknown(data['answered_at']!, _answeredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_answeredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionHistoryTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionHistoryTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lessonId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lesson_id'],
      )!,
      subcategoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subcategory_id'],
      )!,
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      isCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_correct'],
      )!,
      answeredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}answered_at'],
      )!,
    );
  }

  @override
  $QuestionHistoryTableTable createAlias(String alias) {
    return $QuestionHistoryTableTable(attachedDatabase, alias);
  }
}

class QuestionHistoryTableData extends DataClass
    implements Insertable<QuestionHistoryTableData> {
  final int id;
  final String lessonId;
  final String subcategoryId;
  final String questionId;
  final bool isCorrect;
  final DateTime answeredAt;
  const QuestionHistoryTableData({
    required this.id,
    required this.lessonId,
    required this.subcategoryId,
    required this.questionId,
    required this.isCorrect,
    required this.answeredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lesson_id'] = Variable<String>(lessonId);
    map['subcategory_id'] = Variable<String>(subcategoryId);
    map['question_id'] = Variable<String>(questionId);
    map['is_correct'] = Variable<bool>(isCorrect);
    map['answered_at'] = Variable<DateTime>(answeredAt);
    return map;
  }

  QuestionHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return QuestionHistoryTableCompanion(
      id: Value(id),
      lessonId: Value(lessonId),
      subcategoryId: Value(subcategoryId),
      questionId: Value(questionId),
      isCorrect: Value(isCorrect),
      answeredAt: Value(answeredAt),
    );
  }

  factory QuestionHistoryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionHistoryTableData(
      id: serializer.fromJson<int>(json['id']),
      lessonId: serializer.fromJson<String>(json['lessonId']),
      subcategoryId: serializer.fromJson<String>(json['subcategoryId']),
      questionId: serializer.fromJson<String>(json['questionId']),
      isCorrect: serializer.fromJson<bool>(json['isCorrect']),
      answeredAt: serializer.fromJson<DateTime>(json['answeredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lessonId': serializer.toJson<String>(lessonId),
      'subcategoryId': serializer.toJson<String>(subcategoryId),
      'questionId': serializer.toJson<String>(questionId),
      'isCorrect': serializer.toJson<bool>(isCorrect),
      'answeredAt': serializer.toJson<DateTime>(answeredAt),
    };
  }

  QuestionHistoryTableData copyWith({
    int? id,
    String? lessonId,
    String? subcategoryId,
    String? questionId,
    bool? isCorrect,
    DateTime? answeredAt,
  }) => QuestionHistoryTableData(
    id: id ?? this.id,
    lessonId: lessonId ?? this.lessonId,
    subcategoryId: subcategoryId ?? this.subcategoryId,
    questionId: questionId ?? this.questionId,
    isCorrect: isCorrect ?? this.isCorrect,
    answeredAt: answeredAt ?? this.answeredAt,
  );
  QuestionHistoryTableData copyWithCompanion(
    QuestionHistoryTableCompanion data,
  ) {
    return QuestionHistoryTableData(
      id: data.id.present ? data.id.value : this.id,
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      subcategoryId: data.subcategoryId.present
          ? data.subcategoryId.value
          : this.subcategoryId,
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
      answeredAt: data.answeredAt.present
          ? data.answeredAt.value
          : this.answeredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionHistoryTableData(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('subcategoryId: $subcategoryId, ')
          ..write('questionId: $questionId, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('answeredAt: $answeredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    lessonId,
    subcategoryId,
    questionId,
    isCorrect,
    answeredAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionHistoryTableData &&
          other.id == this.id &&
          other.lessonId == this.lessonId &&
          other.subcategoryId == this.subcategoryId &&
          other.questionId == this.questionId &&
          other.isCorrect == this.isCorrect &&
          other.answeredAt == this.answeredAt);
}

class QuestionHistoryTableCompanion
    extends UpdateCompanion<QuestionHistoryTableData> {
  final Value<int> id;
  final Value<String> lessonId;
  final Value<String> subcategoryId;
  final Value<String> questionId;
  final Value<bool> isCorrect;
  final Value<DateTime> answeredAt;
  const QuestionHistoryTableCompanion({
    this.id = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.subcategoryId = const Value.absent(),
    this.questionId = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.answeredAt = const Value.absent(),
  });
  QuestionHistoryTableCompanion.insert({
    this.id = const Value.absent(),
    required String lessonId,
    required String subcategoryId,
    required String questionId,
    required bool isCorrect,
    required DateTime answeredAt,
  }) : lessonId = Value(lessonId),
       subcategoryId = Value(subcategoryId),
       questionId = Value(questionId),
       isCorrect = Value(isCorrect),
       answeredAt = Value(answeredAt);
  static Insertable<QuestionHistoryTableData> custom({
    Expression<int>? id,
    Expression<String>? lessonId,
    Expression<String>? subcategoryId,
    Expression<String>? questionId,
    Expression<bool>? isCorrect,
    Expression<DateTime>? answeredAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lessonId != null) 'lesson_id': lessonId,
      if (subcategoryId != null) 'subcategory_id': subcategoryId,
      if (questionId != null) 'question_id': questionId,
      if (isCorrect != null) 'is_correct': isCorrect,
      if (answeredAt != null) 'answered_at': answeredAt,
    });
  }

  QuestionHistoryTableCompanion copyWith({
    Value<int>? id,
    Value<String>? lessonId,
    Value<String>? subcategoryId,
    Value<String>? questionId,
    Value<bool>? isCorrect,
    Value<DateTime>? answeredAt,
  }) {
    return QuestionHistoryTableCompanion(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      subcategoryId: subcategoryId ?? this.subcategoryId,
      questionId: questionId ?? this.questionId,
      isCorrect: isCorrect ?? this.isCorrect,
      answeredAt: answeredAt ?? this.answeredAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lessonId.present) {
      map['lesson_id'] = Variable<String>(lessonId.value);
    }
    if (subcategoryId.present) {
      map['subcategory_id'] = Variable<String>(subcategoryId.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<bool>(isCorrect.value);
    }
    if (answeredAt.present) {
      map['answered_at'] = Variable<DateTime>(answeredAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionHistoryTableCompanion(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('subcategoryId: $subcategoryId, ')
          ..write('questionId: $questionId, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('answeredAt: $answeredAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProgressTableTable userProgressTable =
      $UserProgressTableTable(this);
  late final $QuestionHistoryTableTable questionHistoryTable =
      $QuestionHistoryTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userProgressTable,
    questionHistoryTable,
  ];
}

typedef $$UserProgressTableTableCreateCompanionBuilder =
    UserProgressTableCompanion Function({
      Value<int> id,
      Value<String> userName,
      Value<String?> avatarPath,
      Value<bool> isPremium,
      Value<int> lives,
      Value<int> score,
      Value<int> streakDays,
      Value<String> completedLessonIds,
      Value<DateTime?> lastActiveDate,
    });
typedef $$UserProgressTableTableUpdateCompanionBuilder =
    UserProgressTableCompanion Function({
      Value<int> id,
      Value<String> userName,
      Value<String?> avatarPath,
      Value<bool> isPremium,
      Value<int> lives,
      Value<int> score,
      Value<int> streakDays,
      Value<String> completedLessonIds,
      Value<DateTime?> lastActiveDate,
    });

class $$UserProgressTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserProgressTableTable> {
  $$UserProgressTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPremium => $composableBuilder(
    column: $table.isPremium,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lives => $composableBuilder(
    column: $table.lives,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get streakDays => $composableBuilder(
    column: $table.streakDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get completedLessonIds => $composableBuilder(
    column: $table.completedLessonIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastActiveDate => $composableBuilder(
    column: $table.lastActiveDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProgressTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProgressTableTable> {
  $$UserProgressTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPremium => $composableBuilder(
    column: $table.isPremium,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lives => $composableBuilder(
    column: $table.lives,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get streakDays => $composableBuilder(
    column: $table.streakDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completedLessonIds => $composableBuilder(
    column: $table.completedLessonIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastActiveDate => $composableBuilder(
    column: $table.lastActiveDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProgressTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProgressTableTable> {
  $$UserProgressTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => column);

  GeneratedColumn<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPremium =>
      $composableBuilder(column: $table.isPremium, builder: (column) => column);

  GeneratedColumn<int> get lives =>
      $composableBuilder(column: $table.lives, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get streakDays => $composableBuilder(
    column: $table.streakDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get completedLessonIds => $composableBuilder(
    column: $table.completedLessonIds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastActiveDate => $composableBuilder(
    column: $table.lastActiveDate,
    builder: (column) => column,
  );
}

class $$UserProgressTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProgressTableTable,
          UserProgressTableData,
          $$UserProgressTableTableFilterComposer,
          $$UserProgressTableTableOrderingComposer,
          $$UserProgressTableTableAnnotationComposer,
          $$UserProgressTableTableCreateCompanionBuilder,
          $$UserProgressTableTableUpdateCompanionBuilder,
          (
            UserProgressTableData,
            BaseReferences<
              _$AppDatabase,
              $UserProgressTableTable,
              UserProgressTableData
            >,
          ),
          UserProgressTableData,
          PrefetchHooks Function()
        > {
  $$UserProgressTableTableTableManager(
    _$AppDatabase db,
    $UserProgressTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProgressTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProgressTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProgressTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userName = const Value.absent(),
                Value<String?> avatarPath = const Value.absent(),
                Value<bool> isPremium = const Value.absent(),
                Value<int> lives = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> streakDays = const Value.absent(),
                Value<String> completedLessonIds = const Value.absent(),
                Value<DateTime?> lastActiveDate = const Value.absent(),
              }) => UserProgressTableCompanion(
                id: id,
                userName: userName,
                avatarPath: avatarPath,
                isPremium: isPremium,
                lives: lives,
                score: score,
                streakDays: streakDays,
                completedLessonIds: completedLessonIds,
                lastActiveDate: lastActiveDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userName = const Value.absent(),
                Value<String?> avatarPath = const Value.absent(),
                Value<bool> isPremium = const Value.absent(),
                Value<int> lives = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> streakDays = const Value.absent(),
                Value<String> completedLessonIds = const Value.absent(),
                Value<DateTime?> lastActiveDate = const Value.absent(),
              }) => UserProgressTableCompanion.insert(
                id: id,
                userName: userName,
                avatarPath: avatarPath,
                isPremium: isPremium,
                lives: lives,
                score: score,
                streakDays: streakDays,
                completedLessonIds: completedLessonIds,
                lastActiveDate: lastActiveDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProgressTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProgressTableTable,
      UserProgressTableData,
      $$UserProgressTableTableFilterComposer,
      $$UserProgressTableTableOrderingComposer,
      $$UserProgressTableTableAnnotationComposer,
      $$UserProgressTableTableCreateCompanionBuilder,
      $$UserProgressTableTableUpdateCompanionBuilder,
      (
        UserProgressTableData,
        BaseReferences<
          _$AppDatabase,
          $UserProgressTableTable,
          UserProgressTableData
        >,
      ),
      UserProgressTableData,
      PrefetchHooks Function()
    >;
typedef $$QuestionHistoryTableTableCreateCompanionBuilder =
    QuestionHistoryTableCompanion Function({
      Value<int> id,
      required String lessonId,
      required String subcategoryId,
      required String questionId,
      required bool isCorrect,
      required DateTime answeredAt,
    });
typedef $$QuestionHistoryTableTableUpdateCompanionBuilder =
    QuestionHistoryTableCompanion Function({
      Value<int> id,
      Value<String> lessonId,
      Value<String> subcategoryId,
      Value<String> questionId,
      Value<bool> isCorrect,
      Value<DateTime> answeredAt,
    });

class $$QuestionHistoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionHistoryTableTable> {
  $$QuestionHistoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subcategoryId => $composableBuilder(
    column: $table.subcategoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QuestionHistoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionHistoryTableTable> {
  $$QuestionHistoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subcategoryId => $composableBuilder(
    column: $table.subcategoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuestionHistoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionHistoryTableTable> {
  $$QuestionHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get lessonId =>
      $composableBuilder(column: $table.lessonId, builder: (column) => column);

  GeneratedColumn<String> get subcategoryId => $composableBuilder(
    column: $table.subcategoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);

  GeneratedColumn<DateTime> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => column,
  );
}

class $$QuestionHistoryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionHistoryTableTable,
          QuestionHistoryTableData,
          $$QuestionHistoryTableTableFilterComposer,
          $$QuestionHistoryTableTableOrderingComposer,
          $$QuestionHistoryTableTableAnnotationComposer,
          $$QuestionHistoryTableTableCreateCompanionBuilder,
          $$QuestionHistoryTableTableUpdateCompanionBuilder,
          (
            QuestionHistoryTableData,
            BaseReferences<
              _$AppDatabase,
              $QuestionHistoryTableTable,
              QuestionHistoryTableData
            >,
          ),
          QuestionHistoryTableData,
          PrefetchHooks Function()
        > {
  $$QuestionHistoryTableTableTableManager(
    _$AppDatabase db,
    $QuestionHistoryTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionHistoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionHistoryTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$QuestionHistoryTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> lessonId = const Value.absent(),
                Value<String> subcategoryId = const Value.absent(),
                Value<String> questionId = const Value.absent(),
                Value<bool> isCorrect = const Value.absent(),
                Value<DateTime> answeredAt = const Value.absent(),
              }) => QuestionHistoryTableCompanion(
                id: id,
                lessonId: lessonId,
                subcategoryId: subcategoryId,
                questionId: questionId,
                isCorrect: isCorrect,
                answeredAt: answeredAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String lessonId,
                required String subcategoryId,
                required String questionId,
                required bool isCorrect,
                required DateTime answeredAt,
              }) => QuestionHistoryTableCompanion.insert(
                id: id,
                lessonId: lessonId,
                subcategoryId: subcategoryId,
                questionId: questionId,
                isCorrect: isCorrect,
                answeredAt: answeredAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QuestionHistoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionHistoryTableTable,
      QuestionHistoryTableData,
      $$QuestionHistoryTableTableFilterComposer,
      $$QuestionHistoryTableTableOrderingComposer,
      $$QuestionHistoryTableTableAnnotationComposer,
      $$QuestionHistoryTableTableCreateCompanionBuilder,
      $$QuestionHistoryTableTableUpdateCompanionBuilder,
      (
        QuestionHistoryTableData,
        BaseReferences<
          _$AppDatabase,
          $QuestionHistoryTableTable,
          QuestionHistoryTableData
        >,
      ),
      QuestionHistoryTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProgressTableTableTableManager get userProgressTable =>
      $$UserProgressTableTableTableManager(_db, _db.userProgressTable);
  $$QuestionHistoryTableTableTableManager get questionHistoryTable =>
      $$QuestionHistoryTableTableTableManager(_db, _db.questionHistoryTable);
}
