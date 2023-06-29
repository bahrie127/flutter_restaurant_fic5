import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restaurant_fic5/bloc/add_product/add_product_bloc.dart';
import 'package:flutter_restaurant_fic5/bloc/login/login_bloc.dart';
import 'package:flutter_restaurant_fic5/bloc/register/register_bloc.dart';
import 'package:flutter_restaurant_fic5/presentation/pages/add_restaurant_page.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_restaurant_fic5/bloc/gmap/gmap_bloc.dart';
import 'package:flutter_restaurant_fic5/data/local_datasources/auth_local_datasource.dart';
import 'package:flutter_restaurant_fic5/data/remote_datasources/gmap_datasource.dart';
import 'package:flutter_restaurant_fic5/data/remote_datasources/restaurant_datasource.dart';
import 'package:flutter_restaurant_fic5/presentation/pages/detail_restaurant_page.dart';
import 'package:flutter_restaurant_fic5/presentation/pages/home_page.dart';
import 'package:flutter_restaurant_fic5/presentation/pages/login_page.dart';
import 'package:flutter_restaurant_fic5/presentation/pages/my_restaurant_page.dart';
import 'package:flutter_restaurant_fic5/presentation/pages/register_page.dart';

import 'bloc/detail_product/detail_product_bloc.dart';
import 'bloc/get_all_product/get_all_product_bloc.dart';
import 'data/remote_datasources/auth_datasource.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetAllProductBloc(RestaurantDatasource()),
        ),
        BlocProvider(
          create: (context) => DetailProductBloc(RestaurantDatasource()),
        ),
        BlocProvider(
          create: (context) => GmapBloc(GmapDatasource()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(AuthDataSource()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(AuthDataSource()),
        ),
        BlocProvider(
          create: (context) => AddProductBloc(RestaurantDatasource()),
        ),
      ],
      child: MaterialApp.router(
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
            ),
            GoRoute(
              path: '${DetailRestaurantPage.routeName}/:restaurantId',
              builder: (context, state) => DetailRestaurantPage(
                  id: int.parse(state.pathParameters['restaurantId']!)),
            ),
            GoRoute(
              path: MyRestaurantPage.routeName,
              builder: (context, state) => const MyRestaurantPage(),
            ),
            GoRoute(
              path: AddRestaurantPage.routeName,
              builder: (context, state) => const AddRestaurantPage(),
            ),
          ],
        ),
      ),
    );
  }
}
