import 'package:get/get.dart';
import 'package:thor_flutter/app/modules/main/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
  }
}
