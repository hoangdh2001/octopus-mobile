import 'package:flutter/material.dart';
import 'package:octopus/app.dart';
import 'package:octopus/core/config/routes.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/octopus.dart';
import 'package:octopus/octopus_channel.dart';
import 'package:octopus/pages/calls/video_call_page.dart';
import 'package:octopus/pages/channel/channel_page.dart';
import 'package:octopus/pages/email/email_page.dart';
import 'package:octopus/pages/home_page.dart';
import 'package:octopus/pages/main_page.dart';
import 'package:octopus/pages/new_group_page/new_group_page.dart';
import 'package:octopus/pages/new_message_page/new_message_page.dart';
import 'package:octopus/pages/options_signin_screen.dart';
import 'package:octopus/pages/verify/login_page.dart';
import 'package:octopus/pages/welcome_page.dart';

class AppRoutes {
  /// Add entry for new route here
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.WELCOME:
        return MaterialPageRoute(
          settings: RouteSettings(arguments: args, name: Routes.WELCOME),
          builder: (_) => const WelcomePage(),
        );
      case Routes.LOGIN:
        return MaterialPageRoute(
          settings: RouteSettings(arguments: args, name: Routes.LOGIN),
          builder: (_) {
            return const EmailPage();
          },
        );
      case Routes.VERIFY_LOGIN:
        return MaterialPageRoute(
          settings: RouteSettings(arguments: args, name: Routes.VERIFY_LOGIN),
          builder: (_) {
            final verifyLoginPageArgs = args as LoginPageArgs;
            return LoginPage(
              verificationType: verifyLoginPageArgs.verificationType,
              email: verifyLoginPageArgs.email,
            );
          },
        );
      case Routes.LOGIN_OPTION:
        return MaterialPageRoute(
          settings: RouteSettings(arguments: args, name: Routes.LOGIN_OPTION),
          builder: (_) {
            return const OptionsSignInScreen();
          },
        );
      case Routes.APP:
        return MaterialPageRoute(
            settings: RouteSettings(arguments: args, name: Routes.APP),
            builder: (_) {
              return const MyApp();
            });
      case Routes.HOME:
        return MaterialPageRoute(
            settings: RouteSettings(arguments: args, name: Routes.HOME),
            builder: (_) {
              final homePageArgs = args as HomePageArgs;
              return HomePage(
                chatClient: homePageArgs.chatClient,
              );
            });
      case Routes.CHANNEL_PAGE:
        return MaterialPageRoute(
          settings: RouteSettings(arguments: args, name: Routes.CHANNEL_PAGE),
          builder: (context) {
            final channelPageArgs = args as ChannelPageArgs;
            // final initialMessage = channelPageArgs.initialMessage;
            var channel = channelPageArgs.channel;
            if (channel == null) {
              final client = Octopus.of(context).client;
              channel = client.channel(
                id: channelPageArgs.channelID!,
              );
            }

            return OctopusChannel(
              channel: channel,
              // initialMessageId: initialMessage?.id,
              child: Builder(
                builder: (context) {
                  // final parentId = initialMessage?.parentId;
                  // Message? parentMessage;
                  // if (parentId != null) {
                  //   final channel = StreamChannel.of(context).channel;
                  //   parentMessage = channel.state!.messages
                  //       .firstWhereOrNull((it) => it.id == parentId);
                  // }
                  // if (parentMessage != null) {
                  //   return ThreadPage(parent: parentMessage);
                  // }
                  return const ChannelPage();
                },
              ),
            );
          },
        );
      case Routes.NEW_CHAT:
        return MaterialPageRoute(
            settings: RouteSettings(arguments: args, name: Routes.NEW_CHAT),
            builder: (_) {
              return const NewMessagePage();
            });
      case Routes.NEW_GROUP_CHAT:
        return MaterialPageRoute(
            settings:
                RouteSettings(arguments: args, name: Routes.NEW_GROUP_CHAT),
            builder: (_) {
              return const NewGroupPage();
            });
      // case Routes.NEW_GROUP_CHAT_DETAILS:
      //   return MaterialPageRoute(
      //       settings: RouteSettings(
      //           arguments: args, name: Routes.NEW_GROUP_CHAT_DETAILS),
      //       builder: (_) {
      //         return GroupChatDetailsScreen(
      //           selectedUsers: args as List<User>?,
      //         );
      //       });
      // case Routes.CHAT_INFO_SCREEN:
      //   return MaterialPageRoute(
      //       settings:
      //           RouteSettings(arguments: args, name: Routes.CHAT_INFO_SCREEN),
      //       builder: (context) {
      //         return ChatInfoScreen(
      //           user: args as User?,
      //           messageTheme: StreamChatTheme.of(context).ownMessageTheme,
      //         );
      //       });
      // case Routes.GROUP_INFO_SCREEN:
      //   return MaterialPageRoute(
      //       settings:
      //           RouteSettings(arguments: args, name: Routes.GROUP_INFO_SCREEN),
      //       builder: (context) {
      //         return GroupInfoScreen(
      //           messageTheme: StreamChatTheme.of(context).ownMessageTheme,
      //         );
      //       });
      case Routes.MAIN:
        return MaterialPageRoute(
            settings: RouteSettings(arguments: args, name: Routes.MAIN),
            builder: (_) {
              final mainPageArgs = args as MainPageArgs?;
              return MainPage(
                initialIndex: mainPageArgs?.initialIndex ?? 0,
              );
            });
      case Routes.CALL_PAGE:
        return MaterialPageRoute(
            settings: RouteSettings(arguments: args, name: Routes.CALL_PAGE),
            builder: (context) {
              final channelPageArgs = args as VideoCallArgs;
              // final initialMessage = channelPageArgs.initialMessage;
              var channel = channelPageArgs.channel;
              if (channel == null) {
                final client = getIt<Client>();
                channel = client.channel(
                  id: channelPageArgs.channelID!,
                );
              }
              return VideoCallPage(
                channel: channel,
                isJoin: channelPageArgs.isJoin,
              );
            });
      // Default case, should not reach here.
      default:
        return null;
    }
  }
}
