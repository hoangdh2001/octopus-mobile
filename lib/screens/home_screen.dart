import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/screens/channel_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  bool _isSelected(int index) => _currentIndex == index;

  List<BottomNavigationBarItem> get _navBarItems {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            SvgPicture.asset(
              'assets/icons/home.svg',
              color: _isSelected(0) ? Colors.white : const Color(0xff707070),
            ),
          ],
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            SvgPicture.asset(
              'assets/icons/messages.svg',
              color: _isSelected(1) ? Colors.white : const Color(0xff707070),
            ),
          ],
        ),
        label: 'Messages',
      ),
      BottomNavigationBarItem(
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            SvgPicture.asset(
              'assets/icons/project.svg',
              color: _isSelected(2) ? Colors.white : const Color(0xff707070),
            ),
          ],
        ),
        label: 'Project',
      ),
      BottomNavigationBarItem(
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            SvgPicture.asset(
              'assets/icons/bell.svg',
              color: _isSelected(3) ? Colors.white : const Color(0xff707070),
            ),
          ],
        ),
        label: 'Notification',
      ),
      BottomNavigationBarItem(
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            SvgPicture.asset(
              'assets/icons/user.svg',
              color: _isSelected(4) ? Colors.white : const Color(0xff707070),
            ),
          ],
        ),
        label: 'Account',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff1E1D22),
        currentIndex: _currentIndex,
        items: _navBarItems,
        selectedLabelStyle: const TextStyle(
          color: Colors.white,
        ),
        unselectedLabelStyle: const TextStyle(color: Color(0xff707070)),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xff707070),
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Container(),
          Container(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}
