// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:ytyt/features/auth/view/screens/login_screen.dart' as _i1;
import 'package:ytyt/features/auth/view/screens/signup_screen.dart' as _i2;
import 'package:ytyt/features/bottom_nav_screen/bottom_nav_screen.dart' as _i3;
import 'package:ytyt/features/user_profile/view/screens/user_profile_screen.dart'
    as _i4;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    LoginScreenRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginScreen(),
      );
    },
    SignUpScreenRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.SignUpScreen(),
      );
    },
    BottomNavScreenRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BottomNavScreen(),
      );
    },
    UserProfilePageRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.UserProfilePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.LoginScreen]
class LoginScreenRoute extends _i5.PageRouteInfo<void> {
  const LoginScreenRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LoginScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginScreenRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.SignUpScreen]
class SignUpScreenRoute extends _i5.PageRouteInfo<void> {
  const SignUpScreenRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SignUpScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpScreenRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.BottomNavScreen]
class BottomNavScreenRoute extends _i5.PageRouteInfo<void> {
  const BottomNavScreenRoute({List<_i5.PageRouteInfo>? children})
      : super(
          BottomNavScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'BottomNavScreenRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.UserProfilePage]
class UserProfilePageRoute extends _i5.PageRouteInfo<void> {
  const UserProfilePageRoute({List<_i5.PageRouteInfo>? children})
      : super(
          UserProfilePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserProfilePageRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
