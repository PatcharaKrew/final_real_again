import 'package:auto_route/auto_route.dart' as _i7;
import 'package:final_real_again/screen/homeDevice.dart' as _i3;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

   @override
  final Map<String, _i7.PageFactory> pagesMap = {
    HomeDeviceRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.HomeDevicePage(),
      );
    },
  };
}


/// generated route for
/// [_i3.HomeDevicePage]
class HomeDeviceRoute extends _i7.PageRouteInfo<void> {
  const HomeDeviceRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeDeviceRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeDeviceRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
