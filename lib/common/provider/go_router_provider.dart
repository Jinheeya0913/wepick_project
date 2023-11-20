import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth/provider/auth_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final provider = ref.read(authProvider);
  return GoRouter(
    redirect: (_, state) => provider.redirectLogic(state),
    routes: provider.routes,
    initialLocation: '/splash',
    refreshListenable: provider,
    debugLogDiagnostics: true,
  );
});
