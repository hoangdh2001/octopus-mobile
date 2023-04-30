import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/widgets/left_drawer.dart';
import 'package:octopus/widgets/menu_item.dart';
import 'package:octopus/widgets/screen_header.dart';

class OctopusScaffold extends StatefulWidget {
  const OctopusScaffold({super.key, required this.body});

  final Widget? body;

  @override
  State<OctopusScaffold> createState() => _OctopusScaffoldState();
}

class _OctopusScaffoldState extends State<OctopusScaffold> {
  int _currentIndex = 0;

  bool _isSelected(int index) => _currentIndex == index;

  List<MenuItem> get _menuItems {
    return <MenuItem>[
      MenuItem(
        title: "Home",
        urlIcon: "assets/icons/home.svg",
        isSelected: _isSelected(0),
      ),
      MenuItem(
        title: "Notification",
        urlIcon: "assets/icons/notification.svg",
        isSelected: _isSelected(1),
      ),
      MenuItem(
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

  List<Widget> _action(int index) {
    switch (index) {
      case 0:
        return [];
      case 1:
        return [];
      case 2:
        return [
          IconButton(
            splashColor: Colors.transparent,
            onPressed: () {
              context.push('/messages/newMessage');
            },
            icon: SvgPicture.asset(
              'assets/icons/edit.svg',
              color: OctopusTheme.of(context).colorTheme.icon,
            ),
          )
        ];
      default:
        return [];
    }
  }

  String _navigate(int index) {
    switch (index) {
      case 0:
        return '/home';
      case 1:
        return '/notifications';
      case 2:
        return '/messages';
      default:
        return '';
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
        actions: _action(_currentIndex),
      ),
      drawer: LeftDrawer(
        currentIndex: _currentIndex,
        items: _menuItems,
        onTap: (index) {
          setState(() => _currentIndex = index);
          context.go(_navigate(index));
          Navigator.pop(context);
        },
      ),
      body: widget.body,
    );
  }
}
