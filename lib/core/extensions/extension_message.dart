import 'package:octopus/core/data/models/message.dart';
import 'package:octopus/widgets/attachment/utils/attachment_package.dart';

extension MessageX on Message {
  // /// It replaces the user mentions with the actual user names.
  // Message replaceMentions({bool linkify = true}) {
  //   var messageTextToRender = text;
  //   for (final user in mentionedUsers.toSet()) {
  //     final userId = user.id;
  //     final userName = user.name;
  //     if (linkify) {
  //       messageTextToRender = messageTextToRender?.replaceAll(
  //         '@$userId',
  //         '[@$userName](@${userName.replaceAll(' ', '')})',
  //       );
  //     } else {
  //       messageTextToRender = messageTextToRender?.replaceAll(
  //         '@$userId',
  //         '@$userName',
  //       );
  //     }
  //   }
  //   return copyWith(text: messageTextToRender);
  // }

  // /// It returns the message replacing the mentioned user names with
  // ///  the respective user ids
  // Message replaceMentionsWithId() {
  //   if (mentionedUsers.isEmpty) return this;

  //   var messageTextToSend = text;
  //   if (messageTextToSend == null) return this;

  //   for (final user in mentionedUsers.toSet()) {
  //     final userName = user.name;
  //     messageTextToSend = messageTextToSend!.replaceAll(
  //       '@$userName',
  //       '@${user.id}',
  //     );
  //   }

  //   return copyWith(text: messageTextToSend);
  // }

  List<AttachmentPackage> getAttachmentPackageList() {
    final _attachmentPackages = List<AttachmentPackage>.generate(
      attachments.length,
      (index) => AttachmentPackage(
        attachment: attachments[index],
        message: this,
      ),
    );
    return _attachmentPackages;
  }
}
