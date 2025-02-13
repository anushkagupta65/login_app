import 'package:auto_route/auto_route.dart';
import 'package:sign_sphere/src/presentation/home_screen/home_screen.dart';
import 'package:sign_sphere/src/presentation/login_screen/login_screen.dart';
import 'package:sign_sphere/src/presentation/sign_up_screen/sign_up_screen.dart';
import 'package:sign_sphere/src/presentation/splash_screen/splash_screen.dart';
import 'package:sign_sphere/src/utils/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
        MaterialRoute(
            page: SplashRoute.page,
            // initial: true,
            path: SplashScreen.routeName),
        MaterialRoute(
            page: SignUpRoute.page,
            initial: true,
            path: SignUpScreen.routeName),
        MaterialRoute(page: LoginRoute.page, path: LoginScreen.routeName),
        MaterialRoute(page: HomeRoute.page, path: HomeScreen.routeName),
      ];
}
