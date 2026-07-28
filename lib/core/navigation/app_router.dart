import 'package:go_router/go_router.dart';
import 'package:ukrainian/features/auth/presentation/pages/pages.dart';
import 'package:ukrainian/features/dictionary/presentation/pages/dictionary_page.dart';
import 'package:ukrainian/features/home_lessons/presentation/pages/pages.dart';
import 'package:ukrainian/features/leaderboard/presentation/pages/leaderboard_page.dart';
import 'package:ukrainian/features/main_navigation/presentation/pages/main_page.dart';
import 'package:ukrainian/features/profile/presentation/pages/profile_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String createPassword = '/create_password';
  static const String loginPage = '/login_page';
  static const String homePage = '/home_page';
  static const String dictionary = '/dictionary_page';
  static const String leaderboard = '/leaderboard_page';
  static const String mainPage = '/main_page';
  static const String profilePage = '/profile_page';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
      routes: [
        GoRoute(
            path: splash,
            builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
            path: createPassword,
            builder: (context, state) => const CreatePasswordPage(),
        ),
        GoRoute(
            path: loginPage,
            builder: (context, state) => const LoginPage(),
        ),

        StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return MainPage(navigationShell: navigationShell,);
            },
            branches: [
              StatefulShellBranch(
                  routes: [
                    GoRoute(
                        path: homePage,
                        builder: (context, state) => const HomePage(),
                    ),
                  ],
              ),
              StatefulShellBranch(
                  routes: [
                    GoRoute(
                        path: dictionary,
                        builder: (context, state) => const DictionaryPage(),
                    ),
                  ],
              ),
              StatefulShellBranch(
                  routes: [
                    GoRoute(
                        path: leaderboard,
                        builder: (context, state) => const LeaderboardPage(),
                    ),
                  ],
              ),
              StatefulShellBranch(
                  routes: [
                    GoRoute(
                        path: profilePage,
                        builder: (context, state) => const ProfilePage(),
                    ),
                  ],
              ),
            ],
        )
      ],
  );
}