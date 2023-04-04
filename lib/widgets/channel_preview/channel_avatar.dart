import 'package:flutter/material.dart';
import 'package:octopus/widgets/avatar/avatar.dart';

class ChannelAvatar extends StatelessWidget {
  const ChannelAvatar({super.key, this.size = 40});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Avatar(
      size: size,
    );
  }
}
