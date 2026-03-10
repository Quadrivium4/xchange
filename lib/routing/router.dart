import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xchange/pages/app/home/home_view.dart';
import 'package:xchange/pages/app/home/home_view_model.dart';
import 'package:xchange/pages/app/onboarding/onboarding_view.dart';
import 'package:xchange/pages/app/onboarding/onboarding_view_model.dart';
import 'package:xchange/pages/app/settings/settings_view.dart';
import 'package:xchange/pages/auth/login/login_view.dart';
import 'package:xchange/pages/auth/login/login_view_model.dart';
import 'package:xchange/pages/auth/register/register_view.dart';
import 'package:xchange/pages/auth/register/register_view_model.dart';
import 'package:xchange/providers/app.dart';
import 'package:xchange/providers/auth.dart';
import 'package:xchange/providers/user.dart';
import 'package:xchange/routing/app_scaffold.dart';
import 'package:xchange/routing/auth_scaffold.dart';
import 'package:provider/provider.dart';

bool getLogged() {
  return false;
}

GoRouter appRouter(AuthProvider authProvider) => GoRouter(
  refreshListenable: authProvider,
  redirect: (context, state) {
    final loading = authProvider.loading;
    print("redirecting ${state.matchedLocation}");
    final logged = authProvider.logged;
    print("logged: $logged");

    if (!logged &&
        state.matchedLocation != "/register" &&
        state.matchedLocation != "login") {
      return "/login"; // Qui c'era "/login", mi pare di capire che il router fosse da finire, ho messo register per poter fare l'altra pagina
    } else if (logged &&
        (state.matchedLocation == "/register" ||
            state.matchedLocation == "/login")) {
      return "/";
    } else if(logged && authProvider.user!.onboarded == false && state.matchedLocation != "/onboarding"){
      return "/onboarding";
    } else if(logged && authProvider.user!.onboarded == true && state.matchedLocation == "/onboarding"){
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
        GoRoute(
          path: "/login",
          builder: (context, state) {
            final viewModel = LoginViewModel(authProvider: authProvider);

            return ChangeNotifierProvider(
              create: (_) => viewModel,
              child: LoginView(),
            );
          },
        ),
        GoRoute(
          path: "/register",
          builder: (context, state) {
            final viewModel = RegisterViewModel(authProvider: authProvider);
            return ChangeNotifierProvider(
              create: (_) => viewModel,
              child: RegisterView(),
            );
          },
        ),
      ],
    ),
  
    ShellRoute(
      builder: (context, state, child) {
        return AppProviders(child: child);
      },
      routes: [
        GoRoute(
          path: "/onboarding",
          builder: (context, state) {
            final viewModel = OnboardingViewModel();
            return ChangeNotifierProvider(
              create: (context) => viewModel,
              child: Scaffold(body: OnboardingView()),
            );
          },
        ),
        StatefulShellRoute.indexedStack(

          builder: (context, state, navigationShell) {
            return AppScaffold(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: "/", 
                  builder: (context, state) { 
                    final viewModel = HomeViewModel();
                      return ChangeNotifierProvider(
                        create: (context) => viewModel,
                        child: HomeView(),
                      );
                    }),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: "/settings",
                  builder: (context, state) => SettingsView(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});
  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AuthProvider>().loading;
    if(loading) {
      return MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }
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
