import 'package:get/get.dart';
import 'package:thor_flutter/app/modules/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
