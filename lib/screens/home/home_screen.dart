import 'package:flutter/material.dart';
import 'package:restaurant_booking/screens/home/home_controller.dart';
import 'package:get/get.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController=Get.put<HomeController>(HomeController(),tag: "HomeCOntroller");
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: _homeController.logOut,
                child: const Text("LOG OUT")
            )
          ],
        ),
      ),
    );
  }
}
