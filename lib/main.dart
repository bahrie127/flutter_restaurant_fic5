import 'package:flutter/material.dart';
import 'package:flutter_restaurant_fic5/data/local_datasources/auth_local_datasource.dart';
import 'package:flutter_restaurant_fic5/data/models/responses/auth_response_model.dart';
import 'package:flutter_restaurant_fic5/presentation/pages/home_page.dart';
import 'package:flutter_restaurant_fic5/presentation/pages/login_page.dart';
import 'package:flutter_restaurant_fic5/presentation/pages/my_restaurant_page.dart';
import 'package:flutter_restaurant_fic5/presentation/pages/register_page.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: GoRouter(
        initialLocation: HomePage.routeName,
        routes: [
          GoRoute(
            path: LoginPage.routeName,
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: RegisterPage.routeName,
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: HomePage.routeName,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: MyRestaurantPage.routeName,
            builder: (context, state) {
              return const MyRestaurantPage();
            },
            redirect: (context, state) async {
              final isLogin = await AuthLocalDatasource().isLogin();
              if (isLogin) {
                return null;
              } else {
                return LoginPage.routeName;
              }
            },
          )
        ],
      ),
    );
  }
}
