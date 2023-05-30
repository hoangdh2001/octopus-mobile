import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/data/models/member.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/better_stream_builder.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/widgets/indicators/typing_indicator.dart';

class ChannelInfo extends StatelessWidget {
  const ChannelInfo({
    super.key,
    required this.channel,
    this.textStyle,
    this.showTypingIndicator = true,
    this.parentId,
  });

  final Channel channel;

  final TextStyle? textStyle;

  final bool showTypingIndicator;

  final String? parentId;

  @override
  Widget build(BuildContext context) {
    final client = OctopusChannel.of(context).channel.client;
    return BetterStreamBuilder<List<Member>>(
        stream: channel.state!.membersStream,
        initialData: channel.state!.members,
        builder: (context, data) =>
            // StreamConnectionStatusBuilder(
            //   statusBuilder: (context, status) {
            //     switch (status) {
            //       case ConnectionStatus.connected:
            //         return
            _buildConnectedTitleState(context, data)
        // case ConnectionStatus.connecting:
        //     return _buildConnectingTitleState(context);
        //   case ConnectionStatus.disconnected:
        //     return _buildDisconnectedTitleState(context, client);
        //   default:
        //     return const Offstage();
        // }
        // },
        );
  }

  Widget _buildConnectedTitleState(
    BuildContext context,
    List<Member>? members,
  ) {
    Widget? alternativeWidget;

    final memberCount = channel.memberCount;
    if (memberCount != null && memberCount > 2) {
      var text = '$memberCount Members';
      final onlineCount =
          members?.where((m) => m.user?.active == true).length ?? 0;
      if (
          // channel.ownCapabilities.contains(PermissionType.connectEvents) &&
          onlineCount > 0) {
        text += ', $onlineCount Online';
      }
      alternativeWidget = Text(
        text,
        style: OctopusTheme.of(context).channelHeaderTheme.subtitleStyle,
      );
    } else {
      final userId =
          OctopusChannel.of(context).channel.client.state.currentUser?.id;
      final otherMember = members?.firstWhereOrNull(
        (element) => element.userID != userId,
      );

      if (otherMember != null) {
        if (otherMember.user?.active == true) {
          alternativeWidget = Text(
            'Active now',
            style: textStyle,
          );
        } else {
          alternativeWidget = Text(
            'Active '
            '${Jiffy(otherMember.user?.lastActive).fromNow()} ago',
            style: textStyle,
          );
        }
      }
    }

    if (!showTypingIndicator) {
      return alternativeWidget ?? const Offstage();
    }

    return TypingIndicator(
      parentId: parentId,
      style: textStyle,
      alternativeWidget: alternativeWidget,
    );
  }

  // Widget _buildConnectingTitleState(BuildContext context) => Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         const SizedBox(
  //           height: 16,
  //           width: 16,
  //           child: Center(
  //             child: CircularProgressIndicator(),
  //           ),
  //         ),
  //         const SizedBox(width: 10),
  //         Text(
  //           context.translations.searchingForNetworkText,
  //           style: textStyle,
  //         ),
  //       ],
  //     );

  // Widget _buildDisconnectedTitleState(
  //   BuildContext context,
  //   StreamChatClient client,
  // ) =>
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           context.translations.offlineLabel,
  //           style: textStyle,
  //         ),
  //         TextButton(
  //           style: TextButton.styleFrom(
  //             padding: EdgeInsets.zero,
  //             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //             visualDensity: const VisualDensity(
  //               horizontal: VisualDensity.minimumDensity,
  //               vertical: VisualDensity.minimumDensity,
  //             ),
  //           ),
  //           onPressed: () => client
  //             ..closeConnection()
  //             ..openConnection(),
  //           child: Text(
  //             context.translations.tryAgainLabel,
  //             style: textStyle?.copyWith(
  //               color: StreamChatTheme.of(context).colorTheme.accentPrimary,
  //             ),
  //           ),
  //         ),
  //       ],
  //     );
}
