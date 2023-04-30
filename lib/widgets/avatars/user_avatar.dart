import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/extensions/extension_string.dart';
import 'package:octopus/widgets/avatars/gradient_avatar.dart';

const randomImageBaseUrl = 'https://getstream.io/random_png/';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, this.size = 40, required this.user});

  final User user;

  final double size;

  getInitials(String fullName) =>
      fullName.split(' ').sublist(0, 2).map((name) => name.charAt(0)).join(' ');

  @override
  Widget build(BuildContext context) {
    final backupGradientAvatar = ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: GradientAvatar(
        userId: user.id,
        name: '${user.firstName} ${user.lastName}',
      ),
    );
    Widget avatar = FittedBox(
      fit: BoxFit.cover,
      child: Container(
        constraints: BoxConstraints.tightFor(width: size, height: size),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          imageUrl: user.avatar != null
              ? user.avatar!
              : "$randomImageBaseUrl?name=${getInitials('${user.firstName} ${user.lastName}')}&size=$size",
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
