
import 'package:devvy_proj/com_module/graph_screen.dart';
import 'package:devvy_proj/com_module/tableau/tableau_screen.dart';
import 'package:devvy_proj/home_screen.dart';
import 'package:devvy_proj/valuation_module/tableau/form_head_table.dart';
import 'package:devvy_proj/valuation_module/tableau/tableau_screen.dart';
import 'package:devvy_proj/valuation_module/valuation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class RouteClass {
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
        // Home
        GoRoute(
            path: '/',
          pageBuilder: (context, state) => NoTransitionPage<void>(
              child: const HomeScreen(),
          )
        ),

      // formulaire module evaluation
      GoRoute(
          path: '/module-valuation',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            child: const FormHeadTableScreen(),
          )
      ),

      // tableau module evaluation
      GoRoute(
        path: '/tableau',
        pageBuilder: (context, state) => NoTransitionPage<void>(
            child: const TableauScreen()
        )
      ),

        GoRoute(
        path: '/tableau-com',
        pageBuilder: (context, state) => NoTransitionPage<void>(
            child: TableauScreenCom()
        )
      ),

      GoRoute(
        path: '/graphique-evaluation',
        pageBuilder: (context, state) => NoTransitionPage<void>(
            child: const ValuationScreen()
        )
      ),
      GoRoute(
        path: '/graphique-strategie-com',
        pageBuilder: (context, state) => NoTransitionPage<void>(
            child: const GraphScreen()
        )
      )
    ]
  );
}