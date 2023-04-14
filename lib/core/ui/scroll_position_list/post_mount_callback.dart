import 'package:flutter/widgets.dart';

class PostMountCallback extends StatelessWidget {
  const PostMountCallback({required this.child, this.callback, Key? key})
      : super(key: key);

  final Widget child;

  final void Function()? callback;

  @override
  StatelessElement createElement() => _PostMountCallbackElement(this);

  @override
  Widget build(BuildContext context) => child;
}

class _PostMountCallbackElement extends StatelessElement {
  _PostMountCallbackElement(PostMountCallback widget) : super(widget);

  @override
  void mount(Element? parent, dynamic newSlot) {
    super.mount(parent, newSlot);
    final postMountCallback = widget as PostMountCallback;
    postMountCallback.callback?.call();
  }
}
