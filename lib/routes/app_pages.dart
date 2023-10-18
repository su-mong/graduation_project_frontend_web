import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:vote_engine_frontend_example/screen/main_binding.dart';
import 'package:vote_engine_frontend_example/screen/main_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: '/',
      page: () => const MainScreen(),
      binding: MainBinding(),
      transition: Transition.noTransition,
    ),
  ];
}