import 'package:flutter/material.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/data/models/member.dart';
import 'package:octopus/core/ui/better_stream_builder.dart';
import 'package:octopus/widgets/avatars/user_avatar.dart';

class GroupAvatar extends StatelessWidget {
  const GroupAvatar({
    super.key,
    this.size = 40,
    required this.channel,
    required this.members,
  });

  final Channel channel;

  final List<Member> members;

  final double size;

  @override
  Widget build(BuildContext context) {
    Widget avatar = ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        constraints: BoxConstraints.tightFor(width: size, height: size),
        // decoration: BoxDecoration(color: colorTheme.accentPrimary),
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: members
                    .take(2)
                    .map(
                      (member) => Flexible(
                        fit: FlexFit.tight,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          clipBehavior: Clip.antiAlias,
                          child: Transform.scale(
                            scale: 1.2,
                            child: BetterStreamBuilder<Member>(
                              stream: channel.state!.membersStream.map(
                                (members) => members.firstWhere(
                                  (it) => it.userID == member.userID,
                                  orElse: () => member,
                                ),
                              ),
                              initialData: member,
                              builder: (context, member) => UserAvatar(
                                // showOnlineStatus: false,
                                user: member.user!,
                                // borderRadius: BorderRadius.zero,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            if (members.length > 2)
              Flexible(
                fit: FlexFit.tight,
                child: Flex(
                  direction: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: members
                      .skip(2)
                      .take(2)
                      .map(
                        (member) => Flexible(
                          fit: FlexFit.tight,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            clipBehavior: Clip.antiAlias,
                            child: Transform.scale(
                              scale: 1.2,
                              child: BetterStreamBuilder<Member>(
                                stream: channel.state!.membersStream.map(
                                  (members) => members.firstWhere(
                                    (it) => it.userID == member.userID,
                                    orElse: () => member,
                                  ),
                                ),
                                initialData: member,
                                builder: (context, member) => UserAvatar(
                                  // showOnlineStatus: false,
                                  user: member.user!,
                                  // borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );

    return avatar;
  }
}
