import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/config/routes.dart';
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
import 'package:octopus/pages/channel/channel_page.dart';
import 'package:octopus/widgets/attachment/image_attachment_non_aspect.dart';
import 'package:octopus/widgets/attachment/utils/attachment_package.dart';
import 'package:octopus/widgets/channel/channel_back_button.dart';
import 'package:octopus/widgets/fullscreen_media/fullscreen_media.dart';
import 'package:octopus/widgets/message_search/bloc/message_search_list_bloc.dart';
import 'package:video_player/video_player.dart';

class ChannelMediaDisplayScreen extends StatefulWidget {
  final OCMessageThemeData messageTheme;

  const ChannelMediaDisplayScreen({
    Key? key,
    required this.messageTheme,
  }) : super(key: key);

  @override
  State<ChannelMediaDisplayScreen> createState() =>
      _ChannelMediaDisplayScreenState();
}

class _ChannelMediaDisplayScreenState extends State<ChannelMediaDisplayScreen> {
  final Map<String?, VideoPlayerController?> controllerCache = {};

  late final controller = MessageSearchListBloc(
    client: Octopus.of(context).client,
    filter: Filter.in_(
      '_id',
      [OctopusChannel.of(context).channel.id!],
    ),
    attachmentFilter: Filter.in_('type', const ['image', 'video']),
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
          'Photos and Videos',
          style: TextStyle(
            color: OctopusTheme.of(context).colorTheme.primaryGrey,
            fontSize: 16.0,
          ),
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
        backgroundColor: OctopusTheme.of(context).colorTheme.contentView,
      ),
      body: BlocConsumer<MessageSearchListBloc,
          PagedValueState<String, GetMessageResponse>>(
        bloc: controller,
        listener: (context, state) {},
        builder: (context, value) {
          return value.when(
            (nextPageKey, items, error) {
              if (items.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/pictures.svg',
                        width: 136.0,
                        height: 136.0,
                        color: OctopusTheme.of(context).colorTheme.disabled,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'No media',
                        style: TextStyle(
                          fontSize: 14.0,
                          color:
                              OctopusTheme.of(context).colorTheme.primaryGrey,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Photo and video will appear here',
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
              final media = <_AssetPackage>[];

              for (var item in value.asSuccess.items) {
                if (!item.message.isDeleted &&
                    !(item.message.ignoreUser
                            ?.contains(Octopus.of(context).currentUser!.id) ??
                        false)) {
                  item.message.attachments
                      .where((e) => (e.type == 'image' || e.type == 'video'))
                      .forEach((e) {
                    VideoPlayerController? controller;
                    if (e.type == 'video') {
                      var cachedController = controllerCache[e.url];

                      if (cachedController == null) {
                        controller = VideoPlayerController.network(e.url!);
                        controller.initialize();
                        controllerCache[e.url] = controller;
                      } else {
                        controller = cachedController;
                      }
                    }
                    media.add(_AssetPackage(e, item.message, controller));
                  });
                }
              }

              return LazyLoadScrollView(
                onEndOfPage: () async {
                  if (nextPageKey != null) {
                    controller.add(LoadMore(nextPageKey));
                  }
                },
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, position) {
                    var channel = OctopusChannel.of(context).channel;
                    return Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OctopusChannel(
                                channel: channel,
                                child: FullScreenMedia(
                                  mediaAttachmentPackages: media
                                      .map(
                                        (e) => AttachmentPackage(
                                          attachment: e.attachment,
                                          message: e.message,
                                        ),
                                      )
                                      .toList(),
                                  startIndex: position,
                                  userName:
                                      media[position].message.sender!.name,
                                  onShowMessage: (m, c) async {
                                    final client = Octopus.of(context).client;
                                    final message = m;
                                    final channel = client.channel(
                                      id: c.id,
                                    );
                                    if (channel.state == null) {
                                      await channel.watch();
                                    }
                                    Navigator.pushNamed(
                                      context,
                                      Routes.CHANNEL_PAGE,
                                      arguments: ChannelPageArgs(
                                        channel: channel,
                                        // initialMessage: message,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        child: media[position].attachment.type == 'image'
                            ? IgnorePointer(
                                child: ImageAttachmentNonAspect(
                                  attachment: media[position].attachment,
                                  message: media[position].message,
                                  showTitle: false,
                                  size: Size(
                                    MediaQuery.of(context).size.width * 0.8,
                                    MediaQuery.of(context).size.height * 0.3,
                                  ),
                                  messageTheme: widget.messageTheme,
                                ),
                              )
                            : VideoPlayer(media[position].videoPlayer!),
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

class _AssetPackage {
  Attachment attachment;
  Message message;
  VideoPlayerController? videoPlayer;

  _AssetPackage(this.attachment, this.message, this.videoPlayer);
}
