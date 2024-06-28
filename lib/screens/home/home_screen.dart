import 'package:flutter/material.dart';
import 'package:restaurant_booking/screens/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:restaurant_booking/screens/profile/profile_screen.dart';
import 'package:restaurant_booking/utils/helper.dart';

import 'nav_item.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController=Get.put<HomeController>(HomeController(),tag: "HomeCOntroller");
  int _selectedIndex=0;
  PageController _pageController=PageController();

  final List<NavigationItem> _items = [
    NavigationItem("assets/icons/padlock.png", 'home'.tr, 0),
    NavigationItem("assets/icons/padlock.png", 'Service', 0),
    NavigationItem("assets/icons/profile.png", 'Profile'.tr, 0),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, position) {
            switch (position) {
              case 0:
                return ProfileScreen();
              case 1:
                return ProfileScreen();
              default:
                return ProfileScreen();
            }
          },
          itemCount: 2,
        ),
      ),
      bottomNavigationBar:_bottomNav() ,
    );
  }

  Widget _bottomNav() {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      width: 100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _items.map((item) {
          var itemIndex = _items.indexOf(item);
          return InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = itemIndex;
                _pageController.jumpToPage(_selectedIndex);
              });
            },
            child: navItem(item, _selectedIndex == itemIndex),
          );
        }).toList(),
      ),
    );
  }


  Widget navItem(NavigationItem item, bool isSelected){
    return AnimatedContainer(duration: Duration(milliseconds: 240),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(item.icon,fit: BoxFit.fill,width: 20,color:isSelected?ThemeColors.colorPrimary:Color(0xFF727272),),
          Text(item.title,style: TextStyle(color:isSelected?ThemeColors.colorPrimary:Colors.black ),),
        ],
      ),
    );
  }

}
