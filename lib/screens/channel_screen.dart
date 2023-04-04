import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/config/theme/oc_theme.dart';
import 'package:octopus/widgets/channel/channel_header.dart';
import 'package:octopus/widgets/message_input/message_input.dart';
import 'package:octopus/widgets/message_list/message_list_view.dart';

class ChannelScreenArgs {}

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({super.key});

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: ChannelHeader(
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
                MessageListView(),
              ],
            ),
          ),
          MessageInput(),
        ],
      ),
    );
  }
}
