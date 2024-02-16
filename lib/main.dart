import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wagle_front/common/go_router/go_router.dart';

late Size ratio;

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ratio = Size(MediaQuery.sizeOf(context).width / 400,
        MediaQuery.sizeOf(context).height / 900);
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
            primary: Color(0xFFF9D1E9), secondary: Colors.black),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.black,
        ),
        useMaterial3: true,
      ),
      routerConfig: ref.read(goRouterProvider),
    );
  }
}
