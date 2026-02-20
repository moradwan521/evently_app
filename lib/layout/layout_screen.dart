import 'package:flutter/material.dart';

import '../core/gen/assets.gen.dart';
import '../favorite/favorite_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int selectedBottonBarIndex = 0;

  List<Widget> screens = [ HomeScreen(),FavoriteScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedBottonBarIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedBottonBarIndex,
        onTap: (int index) {
          selectedBottonBarIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: Assets.icons.home.svg(width: 25, height: 25),
            activeIcon: Assets.icons.homeBlack.svg(),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.heart.svg(width: 25, height: 25),
            activeIcon: Assets.icons.heartBlack.svg(width: 25, height: 25),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.user.svg(width: 25, height: 25),
            activeIcon: Assets.icons.userBlack.svg(width: 25, height: 25),
            label: "profile",
          ),
        ],
      ),
    );
  }
}
