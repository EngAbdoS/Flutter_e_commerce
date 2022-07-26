import 'package:ecommirce/screens/cart/cart_history.dart';
import 'package:ecommirce/screens/home/main_food_bage.dart';
import 'package:ecommirce/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

 // late PersistentTabController _controller;


  List page = [
    MainFoodPage(),
    Container(
      child: Center(
        child: Text("next page"),
      ),
    ),
   CartHistory(),
    Container(
      child: Center(
        child: Text("next page"),
      ),
    ),
  ];
void onTapnav(int index){
  setState((){
    _selectedIndex=index;
  });


}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor:  AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: true,
        onTap: onTapnav,
        currentIndex: _selectedIndex,
        selectedFontSize: 0.0,unselectedFontSize: 0.0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
            label:"Home",

          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive,
            ),
            label:"history",

          ), BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            label:"Cart",

          ), BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label:"Me",

          ),
        ],
      ),
    );
  }

@override
  void initState(){
  super.initState();

//  _controller = PersistentTabController(initialIndex: 0);
}/*
  List<Widget> _buildScreens() {
    return [
      MainFoodPage(),
      Container(
        child: Center(
          child: Text("next page"),
        ),
      ),
      Container(
        child: Center(
          child: Text("next page"),
        ),
      ),
      Container(
        child: Center(
          child: Text("next page"),
        ),
      ),
    ];
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.archivebox_fill),
        title: ("Archive"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ), PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.cart_fill),
        title: ("Cart"),
        activeColorPrimary:AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Me"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(


      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }*/

}
