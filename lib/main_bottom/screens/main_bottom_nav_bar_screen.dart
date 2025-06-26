import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_marketplace/home/ui/screens/home_screen.dart';
import 'package:service_marketplace/main_bottom/controllers/main_bottom_nav_controller.dart';


class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  static final String name = '/main-bottom-nav';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(
      builder: (navController) {
        return Scaffold(
          body: _screens[navController.selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: navController.selectedIndex,
            onDestinationSelected: navController.changeIndex,
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.stream_rounded),
                label: 'Live Stream',
              ),
              NavigationDestination(
                icon: Icon(Icons.library_music_rounded),
                label: 'Library',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_outline_rounded),
                label: 'Favorite',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline_rounded),
                label: 'Person',
              ),
            ],
          ),
        );
      },
    );
  }
}
