import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    Widget avatar = FittedBox(
      fit: BoxFit.cover,
      child: Container(
        constraints: BoxConstraints.tightFor(width: 40, height: 40),
        child: CachedNetworkImage(
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
    );

    return Container(
      child: avatar,
    );
  }
}
