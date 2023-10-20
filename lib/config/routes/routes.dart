import 'package:go_router/go_router.dart';
import 'package:synapsis_challenge/features/login/presentation/login_view.dart';
import 'package:synapsis_challenge/features/survei-detail/presentation/survei_detail_view.dart';
import 'package:synapsis_challenge/features/survei/domain/entity/survei.dart';
import 'package:synapsis_challenge/features/survei/presentation/survei_view.dart';
import 'package:synapsis_challenge/tree.dart';

final router = GoRouter(
  initialLocation: '/tree',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(path: '/tree', builder: (context, state) => const Tree()),
    GoRoute(
      path: '/',
      builder: (context, state) => const SurveiView(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/survei-detail',
      builder: (context, state) {
        SurveiEntity survei = state.extra as SurveiEntity;
        return SurveiDetailView(
          survei: survei,
        );
      },
    ),
  ],
);
