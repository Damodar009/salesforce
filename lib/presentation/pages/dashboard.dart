import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce/presentation/pages/home/homePage.dart';
import 'package:salesforce/presentation/pages/menuPage.dart';
import 'package:salesforce/utils/app_colors.dart';
import 'calenderPage.dart';
import 'outlets_page.dart';

class DashboardScreen extends StatefulWidget {
  int index;

  DashboardScreen({Key? key, required this.index}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const OutletScreen(),
    const CalenderScreen(),
    const MenuScreen(),
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
        color: AppColors.buttonColor,
        //   color: AppColors.primaryColor,
        height: 30,
      ),
      label: label,
      icon: SvgPicture.asset(
        icon,
        height: 30,
        color: AppColors.primaryColor,
      ),
    );
  }

  // DateTime currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
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
            buildButtonNavigationBarItem('assets/icons/menu.svg', "menu"),
          ],
        ),
      ),
      body: IndexedStack(index: selectedIndex, children: const [
        HomeScreen(),
        OutletScreen(),
        CalenderScreen(),
        MenuScreen(),
      ]),
    );
  }
}
