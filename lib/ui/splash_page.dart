import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/common/config/flavor_config.dart';
import 'package:flutter_intermediate_story_app/common/enumeration/flavor_type.dart';
import 'package:flutter_intermediate_story_app/data/locale/auth_local_datasource.dart';
import 'package:flutter_intermediate_story_app/provider/splash_provider.dart';
import 'package:flutter_intermediate_story_app/service/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<SplashProvider>(
        create: (ctx) => SplashProvider(
          authService: AuthService(
            locale: AuthLocalDatasource(
              prefs: SharedPreferences.getInstance(),
            ),
          ),
          context: context,
        ),
        child: Consumer<SplashProvider>(
          builder: (context, value, child) {
            return Center(
              child: Text(
                FlavorConfig.instance.flavor == FlavorType.paid
                    ? "Story App"
                    : "Story App FREE",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            );
          },
        ),
      ),
    );
  }
}
