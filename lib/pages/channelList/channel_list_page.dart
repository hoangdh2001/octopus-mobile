import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/core/ui/paged_value_scroll_view/bloc/paged_value_bloc.dart';
import 'package:octopus/core/ui/scroll_view/scroll_view_empty_widget.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/pages/channel/channel_page.dart';
import 'package:octopus/pages/channelList/bloc/channel_list_bloc.dart';
import 'package:octopus/widgets/channel_list/channel_list.dart';

class ChannelListPage extends StatefulWidget {
  const ChannelListPage({super.key});

  @override
  State<ChannelListPage> createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController? _controller;
  late final ChannelListBloc _channelListBloc =
      ChannelListBloc(client: Octopus.of(context).client, limit: 30);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _scrollController.dispose();
    _channelListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      child: NestedScrollView(
        controller: _scrollController,
        floatHeaderSlivers: false,
        headerSliverBuilder: (_, __) => [
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0).r,
              child: CupertinoSearchTextField(
                controller: _controller,
                placeholder: "Search",
                itemColor: OctopusTheme.of(context).colorTheme.icon,
                placeholderStyle: OctopusTheme.of(context).textTheme.hint,
                style: OctopusTheme.of(context).textTheme.primaryGreyBody,
                prefixInsets:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5).r,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 0).r,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          )
        ],
        body: SlidableAutoCloseBehavior(
          closeWhenOpened: true,
          child: RefreshIndicator(
            onRefresh: () async {
              _channelListBloc.add(const Refresh());
            },
            child: ChannelList(
              scrollController: _scrollController,
              controller: _channelListBloc,
              separatorBuilder: (context, values, index) => const Offstage(),
              itemBuilder: (context, channels, index, defaultWidget) {
                final chatTheme = OctopusTheme.of(context);
                final channel = channels[index];
                return Slidable(
                  groupTag: 'channels-actions',
                  endActionPane: ActionPane(
                    motion: const BehindMotion(),
                    children: [
                      CustomSlidableAction(
                        child: Icon(Icons.more_horiz),
                        backgroundColor: Colors.red,
                        onPressed: (_) {},
                      ),
                      CustomSlidableAction(
                        backgroundColor: Colors.pink,
                        child: SvgPicture.asset('assets/icons/trash.svg'),
                        onPressed: (_) async {},
                      ),
                    ],
                  ),
                  child: defaultWidget,
                );
              },
              onChannelTap: (channel) {
                Navigator.pushNamed(context, Routes.CHANNEL_PAGE,
                    arguments: ChannelPageArgs(channel: channel));
              },
              emptyBuilder: (context) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ScrollViewEmptyWidget(
                      emptyIcon: SvgPicture.asset(
                        'assets/icons/message.svg',
                        width: 148,
                        color: OctopusTheme.of(context).colorTheme.disabled,
                      ),
                      emptyTitle: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.NEW_CHAT);
                        },
                        child: Text(
                          'Start a chat',
                          style: OctopusTheme.of(context)
                              .textTheme
                              .primaryGreyBody
                              .copyWith(
                                color: OctopusTheme.of(context)
                                    .colorTheme
                                    .brandPrimary,
                              ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
