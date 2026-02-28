import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xchange/pages/auth/login/login_view.dart';
import 'package:xchange/pages/auth/register/register_view.dart';
import 'package:xchange/providers/auth.dart';
import 'package:xchange/routing/app_scaffold.dart';
import 'package:xchange/routing/auth_scaffold.dart';
import 'package:provider/provider.dart';

bool getLogged(){
  return false;
}

GoRouter appRouter(AuthProvider authProvider) => GoRouter(
  refreshListenable: authProvider,
  redirect: (context, state) {
    final logged = getLogged();
    if(!logged){
      return "/register"; // Qui c'era "/login", mi pare di capire che il router fosse da finire, ho messo register per poter fare l'altra pagina
    }
    return state.matchedLocation;
  },
  routes: [
  ShellRoute(
    
    
    builder: (context, state, child) {
      return AuthScaffold(child: child);
    },
    routes: [
      GoRoute(path: "/login", builder: (context, state) {
        return LoginView();
      },),
      GoRoute(path: "/register", builder: (context, state) {
        return RegisterView();
      },)
    ]
  ),
  StatefulShellRoute.indexedStack(
    
    builder: (context, state, navigationShell) {
      return AppScaffold(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(routes: [
        GoRoute(path: "/", builder: (context, state) => Text("hello home"),)
      ]),
      StatefulShellBranch(routes: [
        GoRoute(path: "/settings", builder: (context, state) => Text("hello settings"),)
      ])
    ])
]);

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter(context.read<AuthProvider>()),
      
    );
  }
}