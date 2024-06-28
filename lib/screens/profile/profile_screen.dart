import 'package:flutter/material.dart';
import 'package:restaurant_booking/screens/profile/profile_controller.dart';
import 'package:restaurant_booking/utils/helper.dart';
import 'package:get/get.dart';
class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});
final ProfileController _profileController=Get.put<ProfileController>(ProfileController(),tag:"ProfileController");
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            20.vs,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(alignment:Alignment.topRight,child: TextButton(
                style: ButtonStyle(
                   backgroundColor:WidgetStateProperty.all(ThemeColors.colorPrimary)
                ),
                  onPressed: (){
                     _profileController.logOut();
                  }, child: const Text("Log Out",style: TextStyle(color: Colors.white),))
              ),
            ),
            20.vs,
            const Text("Profile",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18)),
            20.vs,
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.grey
                      ),
                    child: Image.asset("assets/icons/user.png",width: 15.w,),
                ),
              ),
            ),
            20.vs,
            const Text("Pankaj Singh Bedwal"),
            10.vs,
            const Text("pan567@gmail.com"),
          ],
        ),
      ),
    );
  }
}
