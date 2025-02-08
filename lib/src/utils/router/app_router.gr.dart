// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i6;
import 'package:flutter/material.dart' as _i5;
import 'package:login_app/src/core/auth_service.dart' as _i7;
import 'package:login_app/src/presentation/home_screen.dart' as _i1;
import 'package:login_app/src/presentation/login_screen/login_screen.dart'
    as _i2;
import 'package:login_app/src/presentation/splash_screen/splash_screen.dart'
    as _i3;

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i4.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i5.Key? key,
    required _i6.User user,
    required _i7.AuthService authService,
    List<_i4.PageRouteInfo>? children,
  }) : super(
         HomeRoute.name,
         args: HomeRouteArgs(key: key, user: user, authService: authService),
         initialChildren: children,
       );

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeRouteArgs>();
      return _i1.HomeScreen(
        key: args.key,
        user: args.user,
        authService: args.authService,
      );
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.key,
    required this.user,
    required this.authService,
  });

  final _i5.Key? key;

  final _i6.User user;

  final _i7.AuthService authService;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, user: $user, authService: $authService}';
  }
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i4.PageRouteInfo<void> {
  const LoginRoute({List<_i4.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoginScreen();
    },
  );
}

/// generated route for
/// [_i3.SplashScreen]
class SplashRoute extends _i4.PageRouteInfo<void> {
  const SplashRoute({List<_i4.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.SplashScreen();
    },
  );
}
