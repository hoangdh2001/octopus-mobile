import 'package:flutter/material.dart';
import 'package:octopus/core/data/models/attachment.dart';
import 'package:octopus/core/theme/oc_message_theme_data.dart';
import 'package:octopus/core/theme/oc_theme.dart';

class AttachmentTitle extends StatelessWidget {
  /// Supply attachment and theme for constructing title
  const AttachmentTitle({
    super.key,
    required this.attachment,
    required this.messageTheme,
  });

  /// Theme to apply to text
  final OCMessageThemeData messageTheme;

  /// Attachment data to display
  final Attachment attachment;

  @override
  Widget build(BuildContext context) {
    final ogScrapeUrl = 'Hello';
    // attachment.ogScrapeUrl;
    return GestureDetector(
      onTap: () {
        // final ogScrapeUrl = attachment.ogScrapeUrl;
        // if (ogScrapeUrl != null) launchURL(context, ogScrapeUrl);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (attachment.title != null)
              Text(
                attachment.title!,
                overflow: TextOverflow.ellipsis,
                style: messageTheme.messageTextStyle?.copyWith(
                  color: OctopusTheme.of(context).colorTheme.brandPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (ogScrapeUrl != null)
              Text(ogScrapeUrl, style: messageTheme.messageTextStyle),
          ],
        ),
      ),
    );
  }
}
