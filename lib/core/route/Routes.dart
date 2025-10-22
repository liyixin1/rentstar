import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentstar/features/pages/home/city_selector_page.dart';
import 'package:rentstar/features/tab_page.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch(setting.name){
    //首页tab
      case RoutePath.tab:
        return pageRoute(TabPage(), settings: setting);
      case RoutePath.citySelector:
        return pageRoute(CitySelectorPage());
    }
    return pageRoute(
      Scaffold(
        body: SafeArea(
          child: Center(
            child: Text('No route defined for ${setting.name}'),
          ),
        ),));
  }

  static MaterialPageRoute pageRoute(
      Widget page, {
        RouteSettings? settings,
        bool? fullscreenDialog,
        bool? maintainState,
        bool? allowSnapshotting,
      }) {
    return MaterialPageRoute(
        builder: (context) => page,
        settings: settings,
        fullscreenDialog: fullscreenDialog ?? false,
        maintainState: maintainState ?? true,
        allowSnapshotting: allowSnapshotting ?? true);
  }
}

class RoutePath{
  // 首页
  static const String tab = "/";
  // 城市选择页
  static const String citySelector = "CitySelectorPage";
}