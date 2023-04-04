import 'package:flutter/material.dart';

class ChannelName extends StatelessWidget {
  const ChannelName({
    super.key,
    this.textStyle,
    this.textOverflow = TextOverflow.ellipsis,
  });

  final TextStyle? textStyle;

  final TextOverflow textOverflow;

  @override
  Widget build(BuildContext context) => Text(
        "Test",
        style: textStyle,
        overflow: textOverflow,
      );

  // Widget _generateName(
  //   User currentUser,
  //   List<Member> members,
  // ) =>
  //     LayoutBuilder(
  //       builder: (context, constraints) {
  //         var channelName = context.translations.noTitleText;
  //         final otherMembers = members.where(
  //           (member) => member.userId != currentUser.id,
  //         );

  //         if (otherMembers.isNotEmpty) {
  //           if (otherMembers.length == 1) {
  //             final user = otherMembers.first.user;
  //             if (user != null) {
  //               channelName = user.name;
  //             }
  //           } else {
  //             final maxWidth = constraints.maxWidth;
  //             final maxChars = maxWidth / (textStyle?.fontSize ?? 1);
  //             var currentChars = 0;
  //             final currentMembers = <Member>[];
  //             otherMembers.forEach((element) {
  //               final newLength =
  //                   currentChars + (element.user?.name.length ?? 0);
  //               if (newLength < maxChars) {
  //                 currentChars = newLength;
  //                 currentMembers.add(element);
  //               }
  //             });

  //             final exceedingMembers =
  //                 otherMembers.length - currentMembers.length;
  //             channelName =
  //                 '${currentMembers.map((e) => e.user?.name).join(', ')} '
  //                 '${exceedingMembers > 0 ? '+ $exceedingMembers' : ''}';
  //           }
  //         }

  //         return Text(
  //           channelName,
  //           style: textStyle,
  //           overflow: textOverflow,
  //         );
  //       },
  //     );
}
