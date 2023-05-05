import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/data/models/member.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/better_stream_builder.dart';
import 'package:octopus/widgets/avatars/group_avatar.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';

class ChannelAvatar extends StatelessWidget {
  const ChannelAvatar({
    super.key,
    this.borderRadius,
    required this.channel,
    this.onTap,
    this.constraints,
  });

  final BorderRadius? borderRadius;

  final Channel channel;

  final VoidCallback? onTap;

  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    final client = channel.client.state;

    final chatThemeData = OctopusTheme.of(context);
    final colorTheme = chatThemeData.colorTheme;
    final previewTheme = chatThemeData.channelPreviewThemeData.avatarTheme;

    return BetterStreamBuilder(
      stream: channel.imageStream,
      builder: (context, channelImage) {
        final child = ClipRRect(
          borderRadius: borderRadius ?? previewTheme?.borderRadius,
          child: Container(
            constraints: constraints ?? previewTheme?.constraints,
            decoration: BoxDecoration(color: colorTheme.brandPrimary),
            child: InkWell(
              onTap: onTap,
              child: CachedNetworkImage(
                imageUrl: channelImage,
                errorWidget: (_, __, ___) => Center(
                  child: Text(
                    channel.name?[0] ?? '',
                    style: TextStyle(
                      color: colorTheme.contentView,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
        return child;
      },
      noDataBuilder: (context) {
        final currentUser = client.currentUser!;
        final otherMembers = channel.state!.members
            .where((it) => it.userID != currentUser.id)
            .toList();

        if (otherMembers.isEmpty) {
          return BetterStreamBuilder<User>(
            stream: client.currentUserStream.map((it) => it!),
            initialData: currentUser,
            builder: (context, user) => UserAvatar(
              borderRadius: borderRadius ?? previewTheme?.borderRadius,
              user: user,
              constraints: constraints ?? previewTheme?.constraints,
              // onTap: onTap != null ? (_) => onTap!() : null,
              // selected: selected,
              // selectionColor: selectionColor ?? colorTheme.accentPrimary,
              // selectionThickness: selectionThickness,
            ),
          );
        }

        if (otherMembers.length == 1) {
          final member = otherMembers.first;
          return BetterStreamBuilder<Member>(
            stream: channel.state!.membersStream.map(
              (members) => members.firstWhere(
                (it) => it.userID == member.userID,
                orElse: () => member,
              ),
            ),
            initialData: member,
            builder: (context, member) => UserAvatar(
              borderRadius: borderRadius ?? previewTheme?.borderRadius,
              user: member.user!,
              constraints: constraints ?? previewTheme?.constraints,
              // onTap: onTap != null ? (_) => onTap!() : null,
              // selected: selected,
              // selectionColor: selectionColor ?? colorTheme.accentPrimary,
              // selectionThickness: selectionThickness,
            ),
          );
        }

        return GroupAvatar(
          channel: channel,
          members: otherMembers,
          borderRadius: borderRadius ?? previewTheme?.borderRadius,
          constraints: constraints ?? previewTheme?.constraints,
          // onTap: onTap,
          // selected: selected,
          // selectionColor: selectionColor ?? colorTheme.accentPrimary,
          // selectionThickness: selectionThickness,
        );
      },
    );
  }
}
