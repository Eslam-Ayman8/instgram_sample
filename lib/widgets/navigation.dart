import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgram_sample/screen/explor_screen.dart';
import 'package:instgram_sample/screen/home.dart';
import 'package:instgram_sample/screen/profile_screen.dart';
import 'package:instgram_sample/screen/reelsScreen.dart';
import 'package:instgram_sample/screen/add_screen.dart';

class Navigations_Screen extends StatefulWidget {
  const Navigations_Screen({super.key});

  @override
  State<Navigations_Screen> createState() => _Navigations_ScreenState();
}
int _currentIndex = 0;
class _Navigations_ScreenState extends State<Navigations_Screen> {
  late PageController pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  onPageChanged(int page){
    setState(() {
      _currentIndex = page;
    });
  }
  navigationTapped(int page){
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          onTap: navigationTapped,
          items:  [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home),
            label: ''
            ),
            const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: ''
            ),
            const BottomNavigationBarItem(
                icon: Icon(Icons.camera),
                label: ''
            ),
            BottomNavigationBarItem(
                icon: Image.asset('images/reel_icon.png', height: 20.h,),
                label: ''
            ),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: ''
            ),
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          HomeScreen(),
          ExplorScreen(),
          AddScreen(),
          ReelScreenState(),
          ProfileScreen()
        ],
      )
    );
  }
}
