import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:octopus/config/theme/oc_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/widgets/channel_preview/channel_preview.dart';

class ChannelListScreen extends StatefulWidget {
  const ChannelListScreen({super.key});

  @override
  State<ChannelListScreen> createState() => _ChannelListScreenState();
}

class _ChannelListScreenState extends State<ChannelListScreen> {
  ScrollController _scrollController = ScrollController();
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
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
        body: ListView.separated(
          itemBuilder: (context, index) => ChannelPreview(),
          separatorBuilder: (context, index) => Container(),
          itemCount: 3,
        ),
      ),
    );
  }
}
