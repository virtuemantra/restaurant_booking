import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_booking/screens/home/home_screen.dart';
import 'package:restaurant_booking/utils/extensions.dart';
import 'package:restaurant_booking/utils/helper.dart';
import 'package:restaurant_booking/utils/logger.dart';
import '../../data_provider/social_login_controller.dart';
import '../../utils/const.dart';
import '../../utils/toasty.dart';
class LoginController extends GetxController{
   TextEditingController passwordController=TextEditingController();
   TextEditingController emailController=TextEditingController();
   final RxString status = Status.NORMAL.obs;


   Future<void> loginWithGoogle( ) async {
      status.value = Status.PROGRESS;
      SocialLoginController.google((success, id, name, email, img) async {
         if (success) {
            status.value = Status.PROGRESS;
            Toasty.normal("Login Successfully");
            Preference.setLogin(true);
            Get.offAll(()=>HomeScreen());
            // var json = await Repository.instance.socialLogin(id, 'GOOGLE', name!, email, img);
            // loginSuccess(json, context: context);
         } else {
            status.value = Status.NORMAL;
            Toasty.failed('Unable to login! Please try again later');
         }
         status.value = Status.NORMAL;
      });
   }




   Future<void> signInWithEmailAndPassword() async {
      if(emailController.text.empty){
         Toasty.normal("Please Enter Email");
         return;
      }
      if(passwordController.text.empty){
         Toasty.normal("Please Enter Password");
         return;
      }
      status.value=Status.PROGRESS;
      try {
         UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
         );
         Toasty.normal("Login Successfully");
         Preference.setLogin(true);
         Get.offAll(()=>HomeScreen());
         status.value=Status.NORMAL;
      } catch (e) {
         status.value=Status.NORMAL;
         if (e is FirebaseAuthException) {
            if (e.code == 'user-not-found') {
               Logger.ex(tag: "LOGIN: ",value:"No user found for that email." );
             Toasty.failed("No user found for that email.");

            } else if (e.code == 'wrong-password') {
               Logger.ex(tag: "LOGIN: ",value:"Wrong password provided for that user." );
               Toasty.failed("Wrong password provided for that user.");
            } else {
               Logger.ex(tag: "LOGIN: ",value:"'Error code: ${e.code}" );
            }
         } else {
            Toasty.failed("Something went wrong");
            Logger.ex(tag: "LOGIN: ",value:e.toString() );
         }
      }
   }




}