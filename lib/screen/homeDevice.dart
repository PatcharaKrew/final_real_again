import 'package:final_real_again/screen/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:final_real_again/screen/mainMenu.dart';
import 'package:final_real_again/screen/appointmentDetail.dart';
import 'package:final_real_again/constants/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
          textTheme: GoogleFonts.notoSansThaiTextTheme(),
      ),
      home: HomeDevicePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

@RoutePage()
class HomeDevicePage extends StatefulWidget {
  const HomeDevicePage({super.key});

  @override
  State<HomeDevicePage> createState() => _HomeDevicePageState();
}

class _HomeDevicePageState extends State<HomeDevicePage> {
  int _selectedIndex = 0;

  // Define the pages for each tab
  final List<Widget> _pages = [
    MainMenu(),
    AppointmentDetails(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("หน้าหลัก"),
            selectedColor: bottomBarIconColor,
            unselectedColor: loginBackgroundColor,
          ),

          /// Appointment
          SalomonBottomBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text("รายกาารนัด"),
            selectedColor: bottomBarIconColor,
            unselectedColor: loginBackgroundColor,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("ข้อมูลผู้ใช้"),
            selectedColor: bottomBarIconColor,
            unselectedColor: loginBackgroundColor,
          ),
        ],
        backgroundColor: bottomBarColor,
      ),
    );
  }
}

