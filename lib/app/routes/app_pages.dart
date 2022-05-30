import 'package:get/get.dart';

import 'package:tekata/app/modules/game/bindings/game_binding.dart';
import 'package:tekata/app/modules/game/views/game_view.dart';
import 'package:tekata/app/modules/home/bindings/home_binding.dart';
import 'package:tekata/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.GAME,
      page: () => GameView(),
      binding: GameBinding(),
    ),
  ];
}
