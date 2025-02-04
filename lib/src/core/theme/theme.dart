import 'package:flutter/material.dart';
import "package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart";
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:login_app/src/presentation/core/extentions.dart';

enum ThemeState { light, dark, system }

setThemeDataLight() async {
  await FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  await FlutterStatusbarcolor.setNavigationBarColor('#FAFAFB'.parseColor());
  await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  await FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
}

setThemeDataDark() async {
  await FlutterStatusbarcolor.setStatusBarColor('#121212'.parseColor());
  await FlutterStatusbarcolor.setNavigationBarColor('#121212'.parseColor());
  await FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  await FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
}

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeState.system);

  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    return ThemeState.values[json['value']];
  }

  @override
  Map<String, int> toJson(ThemeState state) {
    return {
      'value': state.index,
    };
  }

  ThemeState get theme => state;

  set theme(ThemeState themeState) => emit(themeState);

  ThemeMode get themeMode {
    switch (state) {
      case ThemeState.light:
        setThemeDataLight();

        return ThemeMode.light;
      case ThemeState.dark:
        setThemeDataDark();

        return ThemeMode.dark;
      case ThemeState.system:
        return ThemeMode.system;
      // default:
      //   return ThemeMode.system;
    }
  }
}
