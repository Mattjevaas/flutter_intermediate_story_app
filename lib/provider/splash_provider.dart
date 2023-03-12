import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/service/auth_service.dart';
import 'package:go_router_flow/go_router_flow.dart';

class SplashProvider extends ChangeNotifier {
  final AuthService _authService;
  final BuildContext _context;

  SplashProvider({
    required AuthService authService,
    required BuildContext context,
  })  : _authService = authService,
        _context = context {
    _checkIsLogin();
  }

  Future<void> _checkIsLogin() async {
    final res = await _authService.isUserLogin();

    if (res) {
      if (_context.mounted) {
        await Future.delayed(const Duration(seconds: 2), () {
          _context.go("/home");
        });
      }
    } else {
      if (_context.mounted) {
        await Future.delayed(const Duration(seconds: 2), () {
          _context.go("/login");
        });
      }
    }
  }
}
