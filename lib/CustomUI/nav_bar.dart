import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../Home.dart';
import '../Screens/Profile.dart';
import '../Screens/Settings.dart';




class NavBar extends StatefulWidget {
  final int initialPage  ;
  const NavBar({Key? key, required this.initialPage}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  /// Controller to handle PageView and also handles initial page
  late PageController _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  late NotchBottomBarController _controller = NotchBottomBarController(index: 0);

  int maxCount = 5;
@override
  void initState() {
  _controller = NotchBottomBarController(index: widget.initialPage);
  _pageController = PageController(initialPage: widget.initialPage);

  // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// widget list
    final List<Widget> bottomBarPages = [
      const Home(),
      const Profile(),
      const Settings(),
    ];
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
        /// Provide NotchBottomBarController
        notchBottomBarController: _controller,
        color: Colors.green,
        showLabel: true,
        textOverflow: TextOverflow.visible,
        maxLine: 1,
        shadowElevation: 5,
        kBottomRadius: 10.0,
        circleMargin: 1,

        notchColor: Colors.orangeAccent,

        /// restart app if you change removeMargins
        removeMargins: false,

        bottomBarWidth: 400,
        showShadow: false,
        durationInMilliSeconds: 1,

        itemLabelStyle: const TextStyle(fontSize: 10),

        elevation: 1,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.home_filled,
              color: Colors.white,
            ),
            activeItem: Icon(
              Icons.home_filled,
              color: Colors.white,
            ),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.person, color: Colors.white),
            activeItem: Icon(
              Icons.person,
              color: Colors.white,
            ),
            itemLabel: 'Profile',

          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            activeItem: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            itemLabel: 'Settings',
          ),

        ],
        onTap: (index) {
          log('current selected index $index');
          _pageController.jumpToPage(index);
        },
        kIconSize: 24.0,
      )
          : null,
    );
  }
}

/// add controller to check weather index through change or not. in page 1

