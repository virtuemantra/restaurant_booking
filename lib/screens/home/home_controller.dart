import 'package:get/get.dart';
import 'package:restaurant_booking/utils/helper.dart';
class HomeController extends GetxController{



  void logOut() {
    Preference.setLogin(false);
  }
}