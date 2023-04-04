import 'package:flutter/material.dart';

class PagedValueListView<K, V> extends StatefulWidget {
  const PagedValueListView({super.key});

  @override
  State<PagedValueListView> createState() => _PagedValueListView();
}

class _PagedValueListView<K, V> extends State<PagedValueListView<K, V>> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => Container(),
      separatorBuilder: (context, index) => Container(),
      itemCount: 0,
    );
  }
}
