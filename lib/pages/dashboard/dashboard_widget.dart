import 'package:flutter/material.dart';
import 'package:license_entrance/app/theme.dart';
import 'package:license_entrance/common/widgets/page_wrapper.dart';
import 'package:license_entrance/pages/dashboard/intial_page/initial_widget.dart';
import 'package:license_entrance/pages/performance/performance_widget.dart';

class DashBoardWidget extends StatefulWidget {
  const DashBoardWidget({super.key});

  @override
  State<DashBoardWidget> createState() => _DashBoardWidgetState();
}

class _DashBoardWidgetState extends State<DashBoardWidget> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    InitialWidget(),
    Center(
      child: Text(
        "📚 Library",
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    ),
    PerformanceWidget(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: "",
      useOwnAppBar: true,
      showBackButton: false,
      body: _screens[_selectedIndex],
      bottomNavBar: Container(
        margin: EdgeInsets.only(bottom: 0),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                activeIcon: Icon(Icons.search_rounded),
                label: 'Library',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_outlined),
                activeIcon: Icon(Icons.bar_chart),
                label: 'Performance',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: CustomTheme.secondaryColor,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
