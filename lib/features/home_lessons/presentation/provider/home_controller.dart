import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/home_lessons/domain/entities/export_entities.dart';
import 'package:ukrainian/features/home_lessons/presentation/provider/home_providers.dart';
import 'package:ukrainian/features/home_lessons/presentation/provider/riverpod_providers_di.dart';

class HomeState {
  final UserProgressEntity userProgress;
  final QuoteEntity quote;
  final List<LessonEntity> lessons;

  const HomeState({
    required this.userProgress,
    required this.quote,
    required this.lessons,
  });

  HomeState copyWith({
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

    ref.listen<AsyncValue<UserProgressEntity>>(userProgressNotifierProvider, (
      previous,
      next,
    ) {
      if (next.hasValue && state.hasValue && next.value != null) {
        state = AsyncValue.data(
          state.value!.copyWith(userProgress: next.value!),
        );
      }
    });

    final userProgressAsync = ref.watch(userProgressNotifierProvider);

    final userProgress =
        userProgressAsync.value ??
        const UserProgressEntity(
          lives: 5,
          score: 0,
          streakDays: 0,
          isPremium: false,
          completedLessonIds: [],
        );
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

    state = state.whenData((data) => data.copyWith(quote: newQuote));
  }
}

final homeControllerProvider = AsyncNotifierProvider<HomeController, HomeState>(
  HomeController.new,
);
