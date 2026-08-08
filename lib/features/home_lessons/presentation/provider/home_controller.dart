import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';
import 'package:ukrainian/features/home_lessons/presentation/provider/home_providers.dart';

class HomeState {
  final UserProgressEntity userProgress;
  final QuoteEntity quote;
  final List<LessonEntity> lessons;

  const HomeState({
    required this.userProgress,
    required this.quote,
    required this.lessons,
  });

  HomeState copyWidth({
    UserProgressEntity? userProgress,
    QuoteEntity? quote,
    List<LessonEntity>? lessons,
  }) {
    return HomeState(
      userProgress: userProgress ?? this.userProgress,
      quote: quote ?? this.quote,
      lessons: lessons ?? this.lessons,
    );
  }
}

class HomeController extends AsyncNotifier<HomeState> {
  @override
  FutureOr<HomeState> build() async {
    final repository = ref.watch(homeRepositoryProvider);

    final userProgress = await repository.getUserProgress();
    final quote = await repository.getRandomQuote();
    final lessons = await repository.getLessons();

    return HomeState(
      userProgress: userProgress,
      quote: quote,
      lessons: lessons,
    );
  }

  // Метод для виклику іншої цитати (наприклад, при натисканні)
  Future<void> refreshQuote() async {
    final repository = ref.watch(homeRepositoryProvider);
    final newQuote = await repository.getRandomQuote();

    state = state.whenData((data) => data.copyWidth(quote: newQuote));
  }

  // Оновлення прогресу (наприклад, зменшення життів або додавання балів)
  Future<void> updateProgress(UserProgressEntity newProgress) async {
    final repository = ref.read(homeRepositoryProvider);
    await repository.updateUserProgress(newProgress);

    state = state.whenData((data) => data.copyWidth(userProgress: newProgress));
  }
}

final homeControllerProvider = AsyncNotifierProvider<HomeController, HomeState>(
  HomeController.new,
);
