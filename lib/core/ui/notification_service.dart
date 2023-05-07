import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    hide Message;
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/data/models/event.dart';
import 'package:octopus/core/data/models/member.dart';
import 'package:octopus/core/data/socketio/event_type.dart';
import 'package:octopus/octopus.dart';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

void showLocalNotification(
  Event event,
  String currentUserId,
  BuildContext context,
) async {
  if (![
        EventType.messageNew,
        EventType.notificationMessageNew,
      ].contains(event.type) ||
      event.message?.sender!.id == currentUserId) {
    return;
  }
  if (event.message == null) return;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher_foreground');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {},
  );
  final initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    onDidReceiveNotificationResponse: (notificationResponse) async {
      final String? channelID = notificationResponse.payload;
      if (channelID != null) {
        final client = Octopus.of(context).client;
        var channel = client.state.channels[channelID];

        if (channel == null) {
          channel = client.channel(
            id: channelID,
          );
          await channel.watch();
        }
        Navigator.pushNamed(context, Routes.CHANNEL_PAGE, arguments: channel);
      }
    },
  );
  final attachmentsLength = event.message?.attachments
          .where((attachment) => attachment.type == 'image')
          .length ??
      0;
  final hasImage = attachmentsLength > 0;

  final client = Octopus.of(context).client;
  final currentUser = Octopus.of(context).client.state.currentUser;
  var channel = client.state.channels[event.channelID];

  if (channel == null) {
    channel = client.channel(
      id: event.channelID,
    );
    await channel.watch();
  }

  final isGroup = channel.memberCount! > 2;

  var channelName = channel.name;
  if (channelName == null) {
    final otherMembers = channel.state!.members.where(
      (member) => member.userID != currentUser!.id,
    );

    if (otherMembers.isNotEmpty) {
      if (otherMembers.length == 1) {
        final user = otherMembers.first.user;
        if (user != null) {
          channelName = user.name;
        }
      } else {
        const maxWidth = 200;
        const maxChars = maxWidth / 11;
        var currentChars = 0;
        final currentMembers = <Member>[];
        for (var element in otherMembers) {
          final newLength = currentChars + (element.user?.name.length ?? 0);
          if (newLength < maxChars) {
            currentChars = newLength;
            currentMembers.add(element);
          }
        }

        final exceedingMembers = otherMembers.length - currentMembers.length;
        channelName = '${currentMembers.map((e) => e.user?.name).join(', ')} '
            '${exceedingMembers > 0 ? '+ $exceedingMembers' : ''}';
      }
    }
  }

  await flutterLocalNotificationsPlugin.show(
    event.message!.id.hashCode,
    isGroup ? channelName : event.message!.sender!.name,
    hasImage
        ? '${isGroup ? '${event.message!.sender!.name}: ' : ''}Đã gửi bạn ${event.message!.attachments.length} ảnh'
        : '${isGroup ? '${event.message!.sender!.name}: ' : ''}${event.message!.text}',
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        channelDescription: 'your channel description',
        priority: Priority.high,
        importance: Importance.high,
      ),
      iOS: DarwinNotificationDetails(
        categoryIdentifier: darwinNotificationCategoryText,
      ),
    ),
    payload: event.channelID,
  );
}
