import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wagle_front/Feed/view/feed_detail_screen.dart';
import 'package:wagle_front/common/const/data.dart';
import 'package:wagle_front/common/view/root_tab.dart';
import 'package:wagle_front/common/view/splash_screen.dart';
import 'package:wagle_front/user/view/login_screen.dart';

part 'go_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final router = GoRouter(
    initialLocation: '/root',
    // redirect: (_, state) {
    //   return _redirectLogin(ref, state);
    // },
    routes: <RouteBase>[
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/root',
        builder: (context, state) => const RootTab(),
      ),
      GoRoute(
        path: '/course/:id',
        builder: (context, state) => FeedDetailScreen(
          id: state.pathParameters['id']!,
        ),
      ),
    ],
  );

  return router;
}

Future<String?> _redirectLogin(Ref ref, GoRouterState state) async {
  final storage = ref.read(storageProvider);
  final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

  if (refreshToken == null) {
    return '/login';
  }
  return null;
}
