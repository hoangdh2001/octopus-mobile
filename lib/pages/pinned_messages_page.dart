import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/data/models/filter.dart';
import 'package:octopus/core/data/models/sort_option.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/pages/channel/channel_page.dart';
import 'package:octopus/widgets/channel/channel_back_button.dart';
import 'package:octopus/widgets/message_search/bloc/message_search_list_bloc.dart';
import 'package:octopus/widgets/message_search/message_search_list_view.dart';

class PinnedMessagesScreen extends StatefulWidget {
  const PinnedMessagesScreen({super.key});

  @override
  State<PinnedMessagesScreen> createState() => _PinnedMessagesScreenState();
}

class _PinnedMessagesScreenState extends State<PinnedMessagesScreen> {
  late final controller = MessageSearchListBloc(
    client: Octopus.of(context).client,
    filter: Filter.in_(
      '_id',
      [OctopusChannel.of(context).channel.id!],
    ),
    messageFilter: Filter.equal(
      'pinned',
      true,
    ),
    sort: [
      const SortOption(
        'createdAt',
        direction: SortOption.ASC,
      ),
    ],
    limit: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(
          'pinned_messages'.tr(),
          style: TextStyle(
            color: OctopusTheme.of(context).colorTheme.primaryGrey,
            fontSize: 16.0,
          ),
        ),
        leading: const BackButton(),
        backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      ),
      body: MessageSearchListView(
        controller: controller,
        emptyBuilder: (_) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/pin.svg',
                  width: 136.0,
                  height: 136.0,
                  color: OctopusTheme.of(context).colorTheme.disabled,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'no_pin_message'.tr(),
                  style: TextStyle(
                    fontSize: 17.0,
                    color: OctopusTheme.of(context).colorTheme.primaryGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'long_press_message'.tr(),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: OctopusTheme.of(context)
                            .colorTheme
                            .primaryGrey
                            .withOpacity(0.5),
                      ),
                    ),
                    TextSpan(
                      text: 'pin_to_conversation'.tr(),
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: OctopusTheme.of(context)
                            .colorTheme
                            .primaryGrey
                            .withOpacity(0.5),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          );
        },
        onMessageTap: (messageResponse) async {
          final client = Octopus.of(context).client;
          final message = messageResponse.message;
          final channel = client.channel(
            id: messageResponse.channel!.id,
          );
          if (channel.state == null) {
            await channel.watch();
          }
          Navigator.pushNamed(
            context,
            Routes.CHANNEL_PAGE,
            arguments: ChannelPageArgs(
              channel: channel,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }
}
