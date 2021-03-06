import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:thor_flutter/app/data/model/customer.dart';
import 'package:thor_flutter/app/data/model/setting.dart';
import 'package:thor_flutter/app/data/provider/local/authentication_local.dart';
import 'package:thor_flutter/app/data/repository/common_repo.dart';
import 'package:thor_flutter/app/global_widgets/error/title_error.dart';
import 'package:thor_flutter/app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  final AuthenticationLocal _authenticationLocal =
      Get.find<AuthenticationLocal>();
  final CommonRepo _commonRepo = Get.find<CommonRepo>();

  String activeRoute = AppRoutes.MAIN;
  Customer customer;
  Setting settings;
  List<Currency> currencies;
  Currency mainCurrency;
  RxInt totalNotifications = 0.obs;
  RxInt totalCart = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    await _bootstrap();
  }

  Future<void> _bootstrap() async {
    await _getSession();
    await _getSettings();
  }

  Future<void> _getSession() async {
    customer = await _authenticationLocal.getSession();
  }

  Future<void> _getSettings() async {
    try {
      settings = await _commonRepo.requestSettings();
      currencies = settings.currencies;
      mainCurrency = settings.currencies.firstWhere((e) => e.isMain == 1);
    } on DioError catch (e) {
      print(e);
      if (e.response != null && e.response != null) {
        Get.dialog(AlertDialog(
            title: TitleAlert(title: 'Ha ocurrido un error'),
            content: Text(e.response.data['message'])));
      }
    } catch (e) {
      print(e);
      Get.dialog(AlertDialog(
          title: TitleAlert(title: 'Ha ocurrido un error'),
          content: Text(e.toString())));
    }
  }

  Future navigateToRoute(String route,
      {bool removeStack = false,
      bool removeStackPartial = false,
      dynamic arguments}) {
    activeRoute = route;
    if (removeStack) {
      return Get.offAllNamed(route);
    } else if (removeStackPartial) {
      return Get.offNamed(route);
    } else {
      return Get.toNamed(route, arguments: arguments);
    }
  }

  Future navigateToMain(int nextCurrentTab) {
    return Get.toNamed(AppRoutes.NAVIGATIONBAR);
  }

  void navigateBack({dynamic result}) {
    Get.back(result: result);
  }

  void closeSession() {
    _authenticationLocal.removeSession();
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
