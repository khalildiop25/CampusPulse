import 'package:go_router/go_router.dart';

import '../features/schedule/presentation/pages/schedule_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [

    GoRoute(
      path: '/',
      builder: (context, state) {
        return const SchedulePage();
      },
    ),
  ],
);