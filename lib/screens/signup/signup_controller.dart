import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_booking/utils/helper.dart';
import 'package:restaurant_booking/utils/logger.dart';
import '../../utils/const.dart';

class SignupController extends GetxController{
  TextEditingController passwordController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  final RxString status = Status.NORMAL.obs;
  bool shouldUseFirebaseEmulator = false;

  // late final FirebaseApp app;
  late final FirebaseAuth auth;


  Future<void> signUpWithEmailAndPassword() async {
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
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if(!userCredential.additionalUserInfo!.isNewUser){
        Toasty.normal("The email address is already in use by another account.");
        return;
      }
      status.value=Status.NORMAL;
    } catch (e) {
      Logger.ex(tag: "SignUp: ",value: e.toString());
      Toasty.normal(e.toString());
      status.value=Status.NORMAL;
    }
  }

}