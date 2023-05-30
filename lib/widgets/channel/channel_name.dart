import 'package:flutter/material.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/data/models/channel_state.dart';
import 'package:octopus/core/data/models/member.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/ui/better_stream_builder.dart';

class ChannelName extends StatelessWidget {
  const ChannelName({
    super.key,
    this.textStyle,
    this.textOverflow = TextOverflow.ellipsis,
    required this.channel,
  });

  final Channel channel;

  final TextStyle? textStyle;

  final TextOverflow textOverflow;

  @override
  Widget build(BuildContext context) => BetterStreamBuilder(
        stream: channel.nameStream,
        initialData: channel.name,
        builder: (context, channelName) => Text(
          channelName,
          style: textStyle,
          overflow: textOverflow,
        ),
        noDataBuilder: (context) => _NameGenerator(
          currentUser: channel.client.state.currentUser!,
          members: channel.state!.members,
          textStyle: textStyle,
          textOverflow: textOverflow,
        ),
      );
}

class _NameGenerator extends StatelessWidget {
  const _NameGenerator({
    required this.currentUser,
    required this.members,
    this.textStyle,
    this.textOverflow,
  });

  final User currentUser;
  final List<Member> members;
  final TextStyle? textStyle;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var channelName = '';
        final otherMembers = members.where(
          (member) => member.userID != currentUser.id,
        );

        if (otherMembers.isNotEmpty) {
          if (otherMembers.length == 1) {
            final user = otherMembers.first.user;
            if (user != null) {
              channelName = user.name;
            }
          } else {
            // final maxWidth = constraints.maxWidth;
            // final maxChars = maxWidth / (textStyle?.fontSize ?? 1);
            // var currentChars = 0;
            final currentMembers = <Member>[];
            otherMembers.forEach((element) {
              // final newLength = currentChars + (element.user?.name.length ?? 0);
              // if (newLength < maxChars) {
              //   currentChars = newLength;
              currentMembers.add(element);
              // }
            });

            final exceedingMembers =
                otherMembers.length - currentMembers.length;
            channelName =
                '${currentMembers.map((e) => e.user?.name).join(', ')} ';
            // '${exceedingMembers > 0 ? '+ $exceedingMembers' : ''}';
          }
        }

        return Text(
          channelName,
          style: textStyle,
          overflow: textOverflow,
        );
      },
    );
  }
}
