import 'package:auto_route/auto_route.dart';
import 'package:final_real_again/router/routes.gr.dart';


@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    CustomRoute(page: HomeDeviceRoute.page, path: '/homeDevice', initial: true),
  ];
}