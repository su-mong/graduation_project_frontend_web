import 'package:get/get.dart';
import 'package:vote_engine_frontend_example/screen/main_view_model.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MainViewModel>(MainViewModel());
  }
}