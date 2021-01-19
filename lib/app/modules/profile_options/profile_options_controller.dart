import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thor_flutter/app/global_widgets/error/title_error.dart';
import 'package:thor_flutter/app/modules/app/app_controller.dart';
import 'package:thor_flutter/app/utils/colors.dart';

class ProfileOptionsController extends GetxController {
  final AppController appCtl = Get.find<AppController>();

  @override
  void onReady() {
    super.onReady();
    _bootstrap();
  }

  void _bootstrap() async {
    await getCountNotifications();
  }

  Future<void> getCountNotifications() async {}

  Future<void> closeSession() async {
    Get.dialog(AlertDialog(
      title: TitleAlert(title: '¿Desea cerrar la sesión?'),
      content: Text('Esperamos que regrese pronto con nosotros'),
      actions: [
        FlatButton(
          child: Text(
            "Aceptar",
            style: TextStyle(color: kPrimaryColor),
          ),
          onPressed: () {
            appCtl.closeSession();
          },
        )
      ],
    ));
  }
}
