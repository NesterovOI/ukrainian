import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ukrainian/features/auth/presentation/pages/pages.dart';
import 'package:ukrainian/features/auth/presentation/provider/auth_state_provider.dart';
import 'package:ukrainian/features/dictionary/domain/entities/rule_entity.dart';
import 'package:ukrainian/features/dictionary/presentation/pages/dictionary_page.dart';
import 'package:ukrainian/features/dictionary/presentation/pages/pages.dart';
import 'package:ukrainian/features/home_lessons/presentation/pages/pages.dart';
import 'package:ukrainian/features/leaderboard/presentation/pages/leaderboard_page.dart';
import 'package:ukrainian/features/main_navigation/presentation/pages/main_page.dart';
import 'package:ukrainian/features/profile/presentation/pages/profile_page.dart';

class AppRouters {
  static const String splash = '/';
  static const String registerPage = '/register_page';
  static const String loginPage = '/login_page';
  static const String homePage = '/home_page';
  static const String dictionary = '/dictionary_page';
  static const String dictionaryName = 'dictionary';
  static const String detailPath = 'detail';
  static const String ruleDetailName = 'ruleDetail';
  static const String leaderboard = '/leaderboard_page';
  static const String mainPage = '/main_page';
  static const String profilePage = '/profile_page';
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  return GoRouter(
    initialLocation: AppRouters.splash,
    routes: [
      GoRoute(path: AppRouters.splash, builder: (context, state) => const SplashPage()),
      GoRoute(
        path: AppRouters.registerPage,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRouters.loginPage,
        builder: (context, state) => const LoginPage(),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouters.homePage,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouters.dictionary,
                name: AppRouters.dictionaryName,
                builder: (context, state) => const DictionaryPage(),
                routes: [
                  GoRoute(
                      path: AppRouters.detailPath,
                      name: AppRouters.ruleDetailName,
                      builder: (context, state) {
                        final rule = state.extra as RuleEntity;
                        return RuleDetailPage(rule: rule);
                      }
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouters.leaderboard,
                builder: (context, state) => const LeaderboardPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRouters.profilePage,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      return authState.when(
        data: (user) {
          final isAuthPage =
              state.matchedLocation == AppRouters.loginPage ||
                  state.matchedLocation == AppRouters.registerPage;
          // 1. Якщо користувач АВТОРИЗОВАНИЙ і знаходиться на сторінці
          // входу/реєстрації
          // -> Відправляємо його на головну сторінку
          if (user != null && isAuthPage) {
            return AppRouters.homePage;
          }
          // 2. Якщо користувач НЕ АВТОРИЗОВАНИЙ і намагається зайти на закриті екрани
          // -> Відправляємо його на сторінку входу
          if (user == null &&
              !isAuthPage &&
              state.matchedLocation != AppRouters.splash) {
            return AppRouters.loginPage;
          }
          return null;
        },
        loading: () => null,
        error: (_, __) => AppRouters.loginPage,
      );
    },
  );
});
