import 'package:auto_route/auto_route.dart';
import 'package:login_app/src/presentation/home_screen.dart';
import 'package:login_app/src/presentation/login_screen/login_screen.dart';
import 'package:login_app/src/utils/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
        MaterialRoute(
            page: LoginRoute.page, initial: true, path: LoginScreen.routeName),
        MaterialRoute(page: HomeRoute.page, path: HomeScreen.routeName),
      ];
}
