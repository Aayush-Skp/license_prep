import 'package:flutter/material.dart';
import 'package:license_entrance/app/data_provider.dart';
import 'package:license_entrance/app/theme.dart';
import 'package:license_entrance/common/widgets/global_snackbar.dart';
import 'package:license_entrance/common/widgets/page_wrapper.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    Center(
      child: Consumer<DataProvider>(
        builder: (context, provider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (provider.responseModel?.data?.length ?? 0).toString(),
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () {
                  GlobalSnackbar.show("SHowing cool");
                },
                child: Text("My Button"),
              ),
            ],
          );
        },
      ),
    ),
    Center(
      child: Text(
        "🔍 Search Screen",
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    ),
    Center(
      child: Text(
        "📊 Performance Screen",
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DataProvider>(
        context,
        listen: false,
      ).fetchData(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: "",
      useOwnAppBar: true,
      showBackButton: false,
      body: _screens[_selectedIndex],
      bottomNavBar: Container(
        margin: EdgeInsets.only(bottom: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
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
                label: 'Search',
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
