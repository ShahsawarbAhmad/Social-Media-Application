import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/view/dashboard/profile/profile.dart';
import 'package:tech_media/view/dashboard/user/user_list_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = PersistentTabController();
  List<Widget> _buildScreen() {
    return [
      // ignore: deprecated_member_use
      SafeArea(
          child: Center(
              child: Text(
        'Home',
        // ignore: deprecated_member_use
        style: Theme.of(context).textTheme.subtitle1,
      ))),
      const Text('Chat'),
      const Text('Add'),
      const UserListScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.home,
        ),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveIcon: Icon(
          Icons.home,
          color: Colors.grey.shade100,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.message),
        inactiveIcon: Icon(
          Icons.message,
          color: Colors.grey.shade100,
        ),
        activeColorPrimary: AppColors.primaryIconColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        inactiveIcon: Icon(
          Icons.add,
          color: Colors.grey.shade100,
        ),
        activeColorPrimary: AppColors.primaryIconColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.message),
        inactiveIcon: Icon(
          Icons.message,
          color: Colors.grey.shade100,
        ),
        activeColorPrimary: AppColors.primaryIconColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_2_outlined),
        inactiveIcon: Icon(
          Icons.person_2_outlined,
          color: Colors.grey.shade100,
        ),
        activeColorPrimary: AppColors.primaryIconColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreen(),
      items: _navBarItem(),
      controller: controller,
      backgroundColor: AppColors.otpHintColor,
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.white,
        borderRadius: BorderRadius.circular(1),
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }
}
