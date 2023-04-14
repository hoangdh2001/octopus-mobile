import 'package:flutter/material.dart';

class GroupAvatar extends StatelessWidget {
  const GroupAvatar({super.key, this.size = 40});

  final double size;

  @override
  Widget build(BuildContext context) {
    Widget avatar = GestureDetector(
      child: ClipRRect(
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
                  // children: members
                  //     .take(2)
                  //     .map(
                  //       (member) => Flexible(
                  //         fit: FlexFit.tight,
                  //         child: FittedBox(
                  //           fit: BoxFit.cover,
                  //           clipBehavior: Clip.antiAlias,
                  //           child: Transform.scale(
                  //             scale: 1.2,
                  //             child: BetterStreamBuilder<Member>(
                  //               stream: channel.state!.membersStream.map(
                  //                 (members) => members.firstWhere(
                  //                   (it) => it.userId == member.userId,
                  //                   orElse: () => member,
                  //                 ),
                  //               ),
                  //               initialData: member,
                  //               builder: (context, member) => StreamUserAvatar(
                  //                 showOnlineStatus: false,
                  //                 user: member.user!,
                  //                 borderRadius: BorderRadius.zero,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //     .toList(),
                ),
              ),
              // if (members.length > 2)
              //   Flexible(
              //     fit: FlexFit.tight,
              //     child: Flex(
              //       direction: Axis.horizontal,
              //       crossAxisAlignment: CrossAxisAlignment.stretch,
              //       children: members
              //           .skip(2)
              //           .take(2)
              //           .map(
              //             (member) => Flexible(
              //               fit: FlexFit.tight,
              //               child: FittedBox(
              //                 fit: BoxFit.cover,
              //                 clipBehavior: Clip.antiAlias,
              //                 child: Transform.scale(
              //                   scale: 1.2,
              //                   child: BetterStreamBuilder<Member>(
              //                     stream: channel.state!.membersStream.map(
              //                       (members) => members.firstWhere(
              //                         (it) => it.userId == member.userId,
              //                         orElse: () => member,
              //                       ),
              //                     ),
              //                     initialData: member,
              //                     builder: (context, member) =>
              //                         StreamUserAvatar(
              //                       showOnlineStatus: false,
              //                       user: member.user!,
              //                       borderRadius: BorderRadius.zero,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           )
              //           .toList(),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );

    return avatar;
  }
}
