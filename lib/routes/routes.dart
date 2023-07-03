part of 'routes_imports.dart';

@AutoRouterConfig(replaceInRouteName: "Route")
class AppRouter extends $AppRouter {


@override      
RouteType get defaultRouteType => const RouteType.material();


  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(page: LoginScreenRoute.page,path: '/'),
        AutoRoute(page: SignUpScreenRoute.page),
        AutoRoute(page: UserProfilePageRoute.page)
      ];
}
