import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/data/models/filter.dart';
import 'package:octopus/core/data/models/get_message_response.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/data/models/sort_option.dart';
import 'package:octopus/core/theme/oc_message_theme_data.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/bloc/paged_value_bloc.dart';
import 'package:octopus/core/ui/scroll_position_list/lazy_load_scroll_view.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/widgets/attachment/file_attachment.dart';
import 'package:octopus/widgets/channel/channel_back_button.dart';
import 'package:octopus/widgets/message_search/bloc/message_search_list_bloc.dart';
import 'package:video_player/video_player.dart';

class ChannelFileDisplayScreen extends StatefulWidget {
  final OCMessageThemeData messageTheme;

  const ChannelFileDisplayScreen({
    Key? key,
    required this.messageTheme,
  }) : super(key: key);

  @override
  State<ChannelFileDisplayScreen> createState() =>
      _ChannelFileDisplayScreenState();
}

class _ChannelFileDisplayScreenState extends State<ChannelFileDisplayScreen> {
  final Map<String?, VideoPlayerController?> controllerCache = {};

  late final controller = MessageSearchListBloc(
    client: Octopus.of(context).client,
    filter: Filter.in_(
      '_id',
      [OctopusChannel.of(context).channel.id!],
    ),
    attachmentFilter: Filter.in_(
      'type',
      const ['raw'],
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
          'Files',
          style: TextStyle(
            color: OctopusTheme.of(context).colorTheme.primaryGrey,
            fontSize: 16.0,
          ),
        ),
        leading: const BackButton(),
        backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      ),
      body: BlocConsumer<MessageSearchListBloc,
          PagedValueState<String, GetMessageResponse>>(
        bloc: controller,
        listener: (context, state) {},
        builder: (
          BuildContext context,
          PagedValueState<String, GetMessageResponse> value,
        ) {
          return value.when(
            (nextPageKey, items, error) {
              if (items.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/files.svg',
                        width: 136.0,
                        height: 136.0,
                        color: OctopusTheme.of(context).colorTheme.disabled,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'No File',
                        style: TextStyle(
                          fontSize: 14.0,
                          color:
                              OctopusTheme.of(context).colorTheme.primaryGrey,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'File appear here',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: OctopusTheme.of(context)
                              .colorTheme
                              .primaryGrey
                              .withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                );
              }
              final media = <Attachment, Message>{};

              for (var item in items) {
                item.message.attachments
                    .where((e) => e.type == 'raw')
                    .forEach((e) {
                  media[e] = item.message;
                });
              }

              return LazyLoadScrollView(
                onEndOfPage: () async {
                  if (nextPageKey != null) {
                    controller.add(LoadMore(nextPageKey));
                  }
                },
                child: ListView.builder(
                  itemBuilder: (context, position) {
                    return Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FileAttachment(
                          message: media.values.toList()[position],
                          attachment: media.keys.toList()[position],
                          size: Size(
                            0.8.sw,
                            0.3.sh,
                          ),
                          showExpanded: true,
                        ),
                      ),
                    );
                  },
                  itemCount: media.length,
                ),
              );
            },
            loading: () => Center(
              child: _getIndicatorWidget(Theme.of(context).platform),
            ),
            error: (_) => const Offstage(),
          );
        },
      ),
    );
  }

  Widget _getIndicatorWidget(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.iOS:
        return const CupertinoActivityIndicator(
          color: Colors.grey,
        );
      case TargetPlatform.android:
      default:
        return const CircularProgressIndicator(
          color: Colors.grey,
        );
    }
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  void initState() {
    controller.add(const DoInitialLoad());
    super.initState();
  }
}
