import 'package:flutter/material.dart';
import 'package:flutter_blog/proviers/post_provider.dart';
import 'package:flutter_blog/screens/createPost_screen.dart';
import 'package:flutter_blog/screens/main_screen.dart';
import 'package:flutter_blog/screens/post_screen.dart';
import 'package:flutter_blog/screens/signIn_screen.dart';
import 'package:flutter_blog/screens/signUp_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
        path: '/',
        builder: (context, state) => const MainScreen(),
        routes: <RouteBase>[
          GoRoute(
              path: 'post/create',
              builder: (context, state) => const CreatePostScreen()),
          GoRoute(
              path: 'post/:postId',
              builder: (context, state) {
                final postId = state.pathParameters['postId'] as String;

                return PostScreen(postId: postId);
              }),
        ]),
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

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => PostProvider()),
  ], child: const MyApp()));
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
