import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:login_app/injection.dart';
import 'package:login_app/src/application/activity_lifecycle_cubit/activity_lifecycle_cubit.dart';
import 'package:login_app/src/application/login/login_cubit.dart';
import 'package:login_app/src/core/theme/theme.dart';
import 'package:login_app/src/presentation/core/theme.dart';
import 'package:login_app/src/presentation/login_screen/login_screen.dart';
import 'package:login_app/src/utils/router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(lazy: false, create: (_) => ActivityLifecycleCubit()),
        BlocProvider(create: (_) => LoginCubit()),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (!kIsWeb) {
      debugPrint('Current application state = $state');
      context
          .read<ActivityLifecycleCubit>()
          .applicationLifecycleChanged(lifecycleState: state);
    }
  }

  @override
  void didChangeDependencies() {
    listenSystemTheme();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void listenSystemTheme() {
    final platformDispatcher = PlatformDispatcher.instance;

    platformDispatcher.onPlatformBrightnessChanged = () {
      final brightness = platformDispatcher.platformBrightness;
      debugPrint("System theme: $brightness");
      debugPrint("Cubit value: ${BlocProvider.of<ThemeCubit>(context).theme}");

      if (BlocProvider.of<ThemeCubit>(context).theme == ThemeState.system) {
        if (brightness == Brightness.dark) {
          setThemeDataDark();
        } else {
          setThemeDataLight();
        }
      }
    };
  }

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              routerConfig: appRouter.config(),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''), // English, no country code
              ],
              onGenerateTitle: (BuildContext context) =>
                  AppLocalizations.of(context)?.appTitle ?? "Default Title",
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: context.watch<ThemeCubit>().themeMode,
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return OrientationBuilder(
                      builder: (context, orientation) {
                        return Scaffold(
                          body: SafeArea(
                            child: child ?? LoginScreen(),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
