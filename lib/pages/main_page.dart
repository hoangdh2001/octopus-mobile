import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/pages/channelList/channel_list_page.dart';
import 'package:octopus/pages/notification_list_screen.dart';
import 'package:octopus/pages/recent_page.dart';
import 'package:octopus/widgets/left_drawer.dart';
import 'package:octopus/widgets/menu_item.dart';
import 'package:octopus/widgets/screen_header.dart';

class MainPageArgs {
  final int initialIndex;

  MainPageArgs({
    this.initialIndex = 0,
  });
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.initialIndex}) : super(key: key);

  final int initialIndex;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _currentIndex = widget.initialIndex;

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
              Navigator.pushNamed(context, Routes.NEW_CHAT);
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

  @override
  Widget build(BuildContext context) {
    final user = Octopus.of(context).currentUser;
    if (user == null) {
      return Offstage();
    }
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
          Navigator.pop(context);
        },
      ),
      drawerEdgeDragWidth: 50,
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          RecentPage(),
          NotificationListScreen(),
          ChannelListPage(),
        ],
      ),
    );
  }

  StreamSubscription<int>? badgeListener;

  @override
  void initState() {
    if (!kIsWeb) {
      badgeListener = Octopus.of(context)
          .client
          .state
          .totalUnreadCountStream
          .listen((count) {
        if (count > 0) {
          FlutterAppBadger.updateBadgeCount(count);
        } else {
          FlutterAppBadger.removeBadge();
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    badgeListener?.cancel();
    super.dispose();
  }
}
