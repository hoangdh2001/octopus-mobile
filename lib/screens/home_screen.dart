import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/config/theme/oc_theme.dart';
import 'package:octopus/widgets/left_drawer.dart';
import 'package:octopus/widgets/menu_item.dart';
import 'package:octopus/widgets/screen_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  bool _isSelected(int index) => _currentIndex == index;

  List<OCMenuItem> get _menuItems {
    return <OCMenuItem>[
      OCMenuItem(
        title: "Home",
        urlIcon: "assets/icons/home.svg",
        isSelected: _isSelected(0),
      ),
      OCMenuItem(
        title: "Notification",
        urlIcon: "assets/icons/notification.svg",
        isSelected: _isSelected(1),
      ),
      OCMenuItem(
        title: "Messages",
        urlIcon: "assets/icons/messages.svg",
        isSelected: _isSelected(2),
      ),
    ];
  }

  String _title(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Notification';
      case 2:
        return 'Messages';
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: ScreenHeader(
        title: _title(_currentIndex),
        leading: Builder(
          builder: (context) => IconButton(
            splashColor: Colors.transparent,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: SvgPicture.asset(
              'assets/icons/menu.svg',
              color: OctopusTheme.of(context).colorTheme.icon,
            ),
          ),
        ),
      ),
      drawer: LeftDrawer(
        currentIndex: _currentIndex,
        items: _menuItems,
        onTap: (index) {
          Navigator.pop(context);
          setState(() => _currentIndex = index);
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Container(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}

// menuItem(
            //   context: context,
            //   title: "Home",
            //   urlIcon: "assets/icons/home.svg",
            //   isSelected: true,
            //   onTap: () {},
            // ),
            // menuItem(
            //   context: context,
            //   title: "Notification",
            //   urlIcon: "assets/icons/notification.svg",
            //   isSelected: false,
            //   onTap: () {},
            // ),
            // menuItem(
            //   context: context,
            //   title: "Messages",
            //   urlIcon: "assets/icons/messages.svg",
            //   isSelected: false,
            //   onTap: () {},
            // ),
