// lib/ui/home/pages/main_page.dart
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import 'history_page.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'setting_page.dart';
import 'user_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final _widgets = [
    // const HomePage(),
    HomeScreen(),
    const HistoryPage(),
    const SettingPage(),
    // const UserPage(),
    // const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgets,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.06),
              blurRadius: 16.0,
              blurStyle: BlurStyle.outer,
              offset: const Offset(0, -8),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            useLegacyColorScheme: false,
            currentIndex: _selectedIndex,
            onTap: (value) => setState(() => _selectedIndex = value),
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(color: Color.fromARGB(255, 114, 76, 175)),
            selectedIconTheme: const IconThemeData(color: Color.fromARGB(255, 114, 76, 175)),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Assets.icons.nav.home.svg(
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 0 ? const Color.fromARGB(255, 114, 76, 175) : AppColors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Assets.icons.nav.history.svg(
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 1 ? const Color.fromARGB(255, 114, 76, 175) : AppColors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Riwayat',
              ),
              BottomNavigationBarItem(
                icon: Assets.icons.nav.setting.svg(
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 2 ? const Color.fromARGB(255, 114, 76, 175) : AppColors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Setting',
              ),
              // BottomNavigationBarItem(
              //   icon: Assets.icons.nav.profile.svg(
              //     colorFilter: ColorFilter.mode(
              //       _selectedIndex == 3 ? const Color.fromARGB(255, 114, 76, 175) : AppColors.grey,
              //       BlendMode.srcIn,
              //     ),
              //   ),
              //   label: 'Profile',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}