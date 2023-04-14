import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/core/theme/oc_theme.dart';

class GeneralCell extends StatelessWidget {
  const GeneralCell({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      margin: const EdgeInsets.symmetric(vertical: 5).h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: OctopusTheme.of(context).colorTheme.cardBackgroundSecondary,
      ),
      padding: const EdgeInsets.all(6).r,
      child: Row(
        children: [
          SizedBox(
            width: 35.w,
            height: 35.w,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              imageUrl: "https://getstream.imgix.net/images/random_svg/H.png",
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
          Text(
            'Do Huy Hoang',
            style: OctopusTheme.of(context).textTheme.primaryGreyBodyBold,
          ),
        ],
      ),
    );
  }
}
