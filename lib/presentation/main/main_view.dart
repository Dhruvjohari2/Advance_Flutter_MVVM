import 'package:advance_mvvm/presentation/main/homePage/home_page.dart';
import 'package:advance_mvvm/presentation/main/notification_page.dart';
import 'package:advance_mvvm/presentation/main/search_page.dart';
import 'package:advance_mvvm/presentation/main/settings_page.dart';
import 'package:advance_mvvm/presentation/resources/color_manager.dart';
import 'package:advance_mvvm/presentation/resources/strings_manager.dart';
import 'package:advance_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [HomePage(), SearchPage(), NotificationPage(), SettingsPage()];
  List<String> titles = ["HomePage", "Search", "Notifications", "Settings"];
  var _title = "Home";
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [BoxShadow(color: ColorManager.black, spreadRadius: AppSize.s1_5)]),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: AppStrings.home),
            BottomNavigationBarItem(icon: Icon(Icons.search),label: AppStrings.search),
            BottomNavigationBarItem(icon: Icon(Icons.notifications),label: AppStrings.notification),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: AppStrings.settings),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
