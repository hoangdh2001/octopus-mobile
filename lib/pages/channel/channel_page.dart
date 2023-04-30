import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/data/client/channel.dart';
import 'package:octopus/core/data/models/enums/message_status.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/widgets/channel/channel_header.dart';
import 'package:octopus/widgets/message_input/message_input.dart';
import 'package:octopus/widgets/message_input/message_input_controller.dart';
import 'package:octopus/widgets/message_list/message_list_view.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({super.key, required this.channel});

  final Channel channel;

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  FocusNode? _focusNode;

  final MessageInputController _messageInputController =
      MessageInputController();

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    super.dispose();
  }

  void _reply(Message message) {
    // _messageInputController.quotedMessage = message;
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _focusNode!.requestFocus();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: ChannelHeader(
        channel: widget.channel,
        showBackButton: true,
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 16, 5),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/phone.svg',
                color: OctopusTheme.of(context).colorTheme.icon,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/cam.svg',
                width: 26,
                color: OctopusTheme.of(context).colorTheme.icon,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                MessageListView(
                  messageBuilder: (context, details, messages, defaultMessage) {
                    return defaultMessage.copyWith(
                      onReplyTap: _reply,
                      // deletedBottomRowBuilder: (context, message) {
                      //   return const StreamVisibleFootnote();
                      // },
                    );
                  },
                ),
              ],
            ),
          ),
          MessageInput(
            focusNode: _focusNode,
            messageInputController: _messageInputController,
          ),
        ],
      ),
    );
  }

  bool defaultFilter(Message m) {
    var _currentUser =
        OctopusChannel.of(context).channel.client.state.currentUser;
    final isMyMessage = m.sender?.id == _currentUser?.id;
    final isDeleted = m.status == MessageStatus.deleted;
    if (isDeleted && !isMyMessage) return false;
    return true;
  }
}
