import 'package:Maitri/automatic.dart';
import 'package:Maitri/pages/breastfeed.dart';
import 'package:Maitri/pages/com.dart';
import 'package:Maitri/pages/guides.dart';
import 'package:Maitri/pages/homelander.dart';
import 'package:Maitri/pages/location.dart';
import 'package:Maitri/pages/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
// Import ReceiverPage

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int _selectedIndex = 2;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(32, 35, 37, 100),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: _widgetOptions(), // Call _widgetOptions as a function
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color.fromRGBO(245, 221, 219, 1),
        items: <Widget>[
          _buildNavItem(Icons.people, 0),
          _buildNavItem(Icons.emergency, 1),
          _buildNavItem(Icons.home, 2),
          _buildNavItem(Icons.book_outlined, 3),
          _buildNavItem(Icons.pin_drop, 4),
        ],
        onTap: _onItemTapped,
        index: _selectedIndex,
        color: Color.fromRGBO(239, 122, 125, 1),
        buttonBackgroundColor: Color.fromRGBO(239, 122, 125, 1),
        height: 60,
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = index == _selectedIndex;
    Color iconColor =
        isSelected ? Colors.pink : Color.fromRGBO(245, 221, 219, 1);

    return Container(
      margin: const EdgeInsets.all(8),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: isSelected
            ? Border.all(color: Colors.pink, width: 2.0)
            : Border.all(color: Colors.transparent),
      ),
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }

  List<Widget> _widgetOptions() {
    DateTime dueDate = DateTime.now(); // Obtain or set dueDate here
    return <Widget>[
      Homelander(),
      ProfileMax(),
      Profile(dueDate: dueDate), // Pass dueDate to ReceiverPage
      NearbyTemplesPage(),
      BreastfeedingTechniquesPage(),
    ];
  }
}
