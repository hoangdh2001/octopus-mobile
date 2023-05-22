import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octopus/core/data/models/enums/message_type.dart';
import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/widgets/attachment/attachment_widget.dart';
import 'package:shimmer/shimmer.dart';

class SystemMessage extends StatelessWidget {
  const SystemMessage({
    super.key,
    required this.message,
    this.onMessageTap,
  });

  final Message message;

  final void Function(Message)? onMessageTap;

  @override
  Widget build(BuildContext context) {
    final message = this.message;

    final messageText = message.text;
    if (messageText == null) return const SizedBox.shrink();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onMessageTap == null ? null : () => onMessageTap!(message),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        child: _buildSystemMessage(context),
      ),
    );
  }

  Widget _buildSystemMessage(BuildContext context) {
    final theme = OctopusTheme.of(context);
    final message = this.message;
    Widget child = Text(
      _buildActionText(context),
      textAlign: TextAlign.center,
      softWrap: true,
      style: theme.textTheme.secondaryGreyCaption2,
    );
    if (message.type == MessageType.systemChangedAvatar) {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          child,
          const SizedBox(width: 5),
          Container(
            constraints: const BoxConstraints.tightFor(width: 20, height: 20),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              imageUrl: message.text!,
              errorWidget: (context, __, ___) =>
                  const AttachmentError(size: Size(20, 20)),
              placeholder: (context, __) {
                final image = Image.asset(
                  'assets/images/placeholder.png',
                  fit: BoxFit.cover,
                );
                final colorTheme = OctopusTheme.of(context).colorTheme;
                return Shimmer.fromColors(
                  baseColor: colorTheme.disabled,
                  highlightColor: colorTheme.brandPrimary,
                  child: image,
                );
              },
              imageBuilder: (context, imageProvider) => DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    return child;
  }

  String _buildActionText(BuildContext context) {
    final message = this.message;
    final currentUser = Octopus.of(context).currentUser;

    final isMyMessage = currentUser!.id == message.sender!.id;
    switch (message.type) {
      case MessageType.systemAddMember:
        return '${isMyMessage ? 'You' : message.sender!.name} added ${message.text} to the group';
      case MessageType.systemMemberLeft:
        return '${isMyMessage ? 'You' : message.sender!.name} left the group';
      case MessageType.systemRemovedMember:
        return '${isMyMessage ? 'You' : message.sender!.name} removed ${message.text} from the group';
      case MessageType.systemCreatedChannel:
        return '${isMyMessage ? 'You' : message.sender!.name} created group';
      case MessageType.systemChangedAvatar:
        return '${isMyMessage ? 'You' : message.sender!.name} changed group avatar';
      case MessageType.systemChangedName:
        return '${isMyMessage ? 'You' : message.sender!.name} changed group name ${message.text}';
      default:
        return '${message.text}';
    }
  }
}
