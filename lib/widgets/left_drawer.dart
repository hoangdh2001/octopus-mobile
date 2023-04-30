import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/widgets/menu_item.dart';
import 'package:octopus/pages/settings/settings_page.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({
    super.key,
    required this.items,
    required this.currentIndex,
    this.onTap,
  });

  final int currentIndex;
  final List<MenuItem> items;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ).r,
        child: Column(
          children: [
            drawerHeader(context),
            ...List<Widget>.generate(
              items.length,
              (index) => GestureDetector(
                onTap: () {
                  onTap?.call(index);
                },
                child: items[index],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16.0,
        right: 8.0,
        left: 8.0,
      ).r,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 35,
                height: 35,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  imageUrl:
                      "https://getstream.imgix.net/images/random_svg/H.png",
                  imageBuilder: (context, imageProvider) => DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Khóa luận tốt nghiệp",
                              style: OctopusTheme.of(context)
                                  .textTheme
                                  .primaryGreyBodyBold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/icons/chevron_down.svg',
                            color: OctopusTheme.of(context).colorTheme.icon,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Do Huy Hoang",
                      style: OctopusTheme.of(context)
                          .textTheme
                          .secondaryGreyCaption2,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  final client = Octopus.of(context).client;
                  showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return SettingsPage(
                            client: client,
                          );
                        },
                      );
                    },
                  );
                },
                child: SvgPicture.asset(
                  'assets/icons/settings.svg',
                  color: OctopusTheme.of(context).colorTheme.icon,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            child: SizedBox(
              height: 30.h,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.2),
                  hintText: "Search",
                  hintStyle: OctopusTheme.of(context).textTheme.hint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 8,
                  ).r,
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/search.svg',
                    color: OctopusTheme.of(context).colorTheme.icon,
                  ),
                  prefixIconConstraints:
                      const BoxConstraints.tightFor(width: 40, height: 15),
                ),
                enabled: false,
                style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
