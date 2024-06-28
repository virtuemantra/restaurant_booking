import 'package:get/get.dart';

import '../../dialogs/exit_dialog.dart';
import '../login/login_controller.dart';

class ProfileController extends GetxController{
  void logOut() {
    ExitDialog("do you want to Log out".tr,() {
      Get.offAll(()=>LoginController());
    },"log out".tr);

    // Preference.clear();

  }

}