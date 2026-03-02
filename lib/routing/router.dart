import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xchange/pages/app/home/home_view.dart';
import 'package:xchange/pages/app/onboarding/onboarding_view.dart';
import 'package:xchange/pages/app/settings/settings_view.dart';
import 'package:xchange/pages/auth/login/login_view.dart';
import 'package:xchange/pages/auth/login/login_view_model.dart';
import 'package:xchange/pages/auth/register/register_view.dart';
import 'package:xchange/pages/auth/register/register_view_model.dart';
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
    print("redirecting ${state.matchedLocation}");
    final logged = authProvider.logged;

    if(!logged && state.matchedLocation != "/register" && state.matchedLocation != "login"){
      
      return "/login"; // Qui c'era "/login", mi pare di capire che il router fosse da finire, ho messo register per poter fare l'altra pagina
    }else if(logged && (state.matchedLocation == "/register" || state.matchedLocation == "/login")){
      return "/";
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
        final viewModel = LoginViewModel(authProvider: authProvider);
        
        return ChangeNotifierProvider(
          create: (_) => viewModel, 
          child: LoginView(),
          );
      },),
      GoRoute(path: "/register", builder: (context, state) {
        final viewModel = RegisterViewModel(authProvider: authProvider);
        return ChangeNotifierProvider(create: (_) => viewModel, child: RegisterView());
      },)
    ]
  ),
  GoRoute(path: "/onboarding", builder: (context, state) => 
  Scaffold(
    body:  OnboardingView(),
  ),),
  StatefulShellRoute.indexedStack(
    
    builder: (context, state, navigationShell) {
      return AppScaffold(navigationShell: navigationShell);
    },
    branches: [

      StatefulShellBranch(routes: [
        GoRoute(path: "/", builder: (context, state) => HomeView(),)
      ]),
      StatefulShellBranch(routes: [
        GoRoute(path: "/settings", builder: (context, state) => SettingsView(),)
      ])
    ])
]);

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // theme: ThemeData(
      //   pageTransitionsTheme: PageTransitionsTheme(
      //     builders: {
      //       TargetPlatform.iOS:  FadeUpwardsPageTransitionsBuilder()
      //     }
      //   )
      // ),
      routerConfig: appRouter(context.read<AuthProvider>()),
      
    );
  }
}