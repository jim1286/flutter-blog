import 'package:flutter/material.dart';
import 'package:flutter_blog/screens/main_screen.dart';
import 'package:flutter_blog/screens/signIn_screen.dart';
import 'package:flutter_blog/screens/signUp_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(path: '/', builder: (context, state) => const MainScreen()),
    GoRoute(path: '/signIn', builder: (context, state) => const SignInScreen()),
    GoRoute(path: '/signUp', builder: (context, state) => const SignUpScreen()),
  ],
  redirect: (context, state) async {
    final bool safetyPath = state.matchedLocation == '/signIn' ||
        state.matchedLocation == '/signUp';

    if (safetyPath) {
      return null;
    }

    final pref = await SharedPreferences.getInstance();
    final accessToken = pref.getString('accessToken');

    if (accessToken == null) {
      return '/signIn';
    }

    return null;
  },
);

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
