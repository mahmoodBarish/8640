import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/display_card.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/display_card',
  routes: <GoRoute>[
    GoRoute(
      path: '/display_card',
      builder: (BuildContext context, GoRouterState state) {
        return const DisplayCard();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: _router,
    );
  }
}
