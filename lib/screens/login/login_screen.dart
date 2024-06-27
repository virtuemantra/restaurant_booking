import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_booking/screens/login/login_controller.dart';
import 'package:restaurant_booking/screens/signup/signup_screen.dart';
import 'package:restaurant_booking/utils/helper.dart';
import 'package:get/get.dart';
import '../../utils/common_widgets.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
final LoginController loginController=Get.put<LoginController>(LoginController(),tag:'LoginController');
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Stack(
          children:[
            ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80,),
              const Center(child: Text("Login",style: TextStyle(fontSize: fontSizeExtraLarge+2,fontWeight:FontWeight.w600),)),
              const SizedBox(height: 20,),
              InputForm("Email","assets/icons/user.png",'Email address',loginController.emailController),
              const SizedBox(height: 10,),
              InputForm("Password","assets/icons/padlock.png",'Password',loginController.passwordController),
              InkWell(
                onTap: ()=>loginController.signInWithEmailAndPassword(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                  constraints:
                  const BoxConstraints(minWidth: double.infinity,),
                  decoration: BoxDecoration(
                    color: ThemeColors.colorPrimary,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: const Center(child: Text("Login",style:TextStyle(color: Colors.white,fontSize:fontSizeLarge,fontWeight: FontWeight.w600),)),
                ),
              ),
              15.hs,
              const Center(child: Text("OR",style: TextStyle(fontSize: 18),)),
              15.vs,
              Center(
                child: InkWell(
                  onTap: loginController.loginWithGoogle,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ]
                    ),
                    child:Image.asset("assets/icons/google.png",width: 40,)
                  ),
                ),
              ),
              50.vs,
              GestureDetector(
                onTap:()=>Get.to(()=> SignupScreen()),
                  child: const Center(child: Text("SIGN UP",style:TextStyle(fontSize: fontSizeLarge,fontWeight: FontWeight.w600) ,)))
            ],
          ),


            Obx(
                ()=>  loginController.status.value==Status.PROGRESS?Center(
                  child: Container(
                  padding: const EdgeInsets.all(5),
                    decoration:  BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: const CircularProgressIndicator(strokeWidth: 2,)
                                ),
                ) :const SizedBox())
          ],
        ),
      ),
    );
  }

}
