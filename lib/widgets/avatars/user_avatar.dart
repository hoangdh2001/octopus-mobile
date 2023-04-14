import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octopus/widgets/avatars/gradient_avatar.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, this.size = 40});

  final double size;

  @override
  Widget build(BuildContext context) {

    final backupGradientAvatar = ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: const GradientAvatar(),
    );
    Widget avatar = FittedBox(
      fit: BoxFit.cover,
      child: Container(
        constraints: BoxConstraints.tightFor(width: size, height: size),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          imageUrl: "https://getstream.imgix.net/images/random_svg/H.png",
          errorWidget: (context, _, __) => backupGradientAvatar,
          imageBuilder: (context, imageProvider) => DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size / 2),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );

    return Container(
      child: avatar,
    );
  }
}
