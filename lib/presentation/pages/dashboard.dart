import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce/presentation/pages/changePasswordPage.dart';
import 'package:salesforce/presentation/pages/login/loginScreen.dart';
import 'package:salesforce/presentation/pages/menuPage.dart';
import 'package:salesforce/presentation/pages/profilePage.dart';
import 'package:salesforce/presentation/pages/salesPage.dart';
import 'package:salesforce/presentation/pages/visitedOutletPage.dart';
import '../widgets/visitedOutletWidget.dart';
import 'attendencePage.dart';
import 'calenderPage.dart';
import 'editProfile.dart';
import 'home/homePage.dart';
import 'newOrderPage.dart';
import 'newOutletsPage.dart';

class DashboardScreen extends StatefulWidget {
  int index;

  DashboardScreen({Key? key, required this.index}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;
  List<Widget> screens = [
    const ProfileScreen(),
    const EditProfileScreen(),
    const CalenderScreen(),
    const VisitedOutletScreen(),

    // const AttendenceScreen(),
    // const MenuScreen()
  ];

  @override
  void initState() {
    selectedIndex = widget.index;

    super.initState();
  }

  BottomNavigationBarItem buildButtonNavigationBarItem(
      String icon, String label) {
    return BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      activeIcon: SvgPicture.asset(
        icon,
        color: Colors.black,
        //   color: AppColors.primaryColor,
        height: 30,
      ),
      label: label,
      icon: SvgPicture.asset(
        icon,
        height: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          currentIndex: selectedIndex,
          elevation: 10,
          selectedItemColor: Colors.red,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            buildButtonNavigationBarItem('assets/icons/home.svg', "Home"),
            buildButtonNavigationBarItem('assets/icons/sales.svg', "sales"),
            buildButtonNavigationBarItem(
                'assets/icons/attendence.svg', "attendence"),
            buildButtonNavigationBarItem('assets/icons/home.svg', "menu"),
          ],
        ),
      ),
      body: screens[selectedIndex],
    );
  }
}
