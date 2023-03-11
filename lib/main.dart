import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/data/locale/auth_local_datasource.dart';
import 'package:flutter_intermediate_story_app/service/auth_service.dart';
import 'package:flutter_intermediate_story_app/ui/add_story_page.dart';
import 'package:flutter_intermediate_story_app/ui/detail_page.dart';
import 'package:flutter_intermediate_story_app/ui/home_page.dart';
import 'package:flutter_intermediate_story_app/ui/login_page.dart';
import 'package:flutter_intermediate_story_app/ui/maps_page.dart';
import 'package:flutter_intermediate_story_app/ui/register_page.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Story App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: GoRouter(
        initialLocation: "/login",
        redirect: (context, GoRouterState state) async {
          final auth = AuthService(
            locale: AuthLocalDatasource(
              prefs: SharedPreferences.getInstance(),
            ),
          );

          if (state.location == "/login" || state.location == "/register") {
            if (await auth.isUserLogin()) {
              return "/home";
            } else {
              return null;
            }
          } else {
            if (await auth.isUserLogin()) {
              return null;
            } else {
              return "/login";
            }
          }
        },
        routes: [
          GoRoute(
            path: "/login",
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: "/register",
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: "/home",
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/detail/:storyId',
            builder: (context, state) => DetailPage(
              restaurantId: state.params['storyId']!,
            ),
          ),
          GoRoute(
            path: '/add',
            builder: (context, state) => const AddStoryPage(),
          ),
          GoRoute(
            path: '/maps/:lat/:lon',
            builder: (context, state) => MapsPage(
              lat: double.parse(state.params['lat']!),
              lon: double.parse(state.params['lon']!),
            ),
          ),
        ],
      ),
    );
  }
}
