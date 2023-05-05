import 'package:flutter/material.dart' hide TextTheme;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octopus/core/theme/mutipleTheme/oc_base_style_guide.dart';
import 'package:octopus/core/theme/oc_avatar_theme_data.dart';
import 'package:octopus/core/theme/oc_button_theme.dart';
import 'package:octopus/core/theme/oc_channel_header_theme.dart';
import 'package:octopus/core/theme/oc_channel_preview_theme_data.dart';
import 'package:octopus/core/theme/oc_color_theme.dart';
import 'package:octopus/core/theme/oc_message_theme_data.dart';
import 'package:octopus/core/theme/oc_style_guide.dart';
import 'package:octopus/core/theme/oc_text_theme.dart';
import 'package:octopus/core/theme/reaction_icon.dart';

/// {@template octopusTheme}
/// Inherited widget providing the [OctopusThemeData] to the widget tree
/// {@endtemplate}
class OctopusTheme extends InheritedWidget {
  /// {@macro octopusTheme}
  const OctopusTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// {@macro octopusThemeData}
  final OctopusThemeData data;

  @override
  bool updateShouldNotify(OctopusTheme oldWidget) => data != oldWidget.data;

  /// Use this method to get the current [OctopusThemeData] instance
  static OctopusThemeData of(BuildContext context) {
    final ocTheme = context.dependOnInheritedWidgetOfExactType<OctopusTheme>();

    assert(
      ocTheme != null,
      'You must have a StreamChatTheme widget at the top of your widget tree',
    );

    return ocTheme!.data;
  }
}

/// {@template octopusTheme}
/// Theme data for Octopus
/// {@endtemplate}
class OctopusThemeData {
  /// Creates a theme from scratch
  final String logo;
  final OCColorTheme colorTheme;
  final OCTextTheme textTheme;
  final OCButtonTheme buttonTheme;
  final OCStyleGuide styleGuide;
  final OCMessageThemeData ownMessageTheme;
  final OCMessageThemeData otherMessageTheme;
  final List<ReactionIcon> reactionIcons;
  final ChannelHeaderTheme channelHeaderTheme;
  final ChannelPreviewThemeData channelPreviewThemeData;

  factory OctopusThemeData({
    Brightness? brightness,
    OCStyleGuide? styleGuide,
    OCColorTheme? colorTheme,
    OCTextTheme? textTheme,
    OCButtonTheme? buttonTheme,
  }) {
    brightness ??= Brightness.light;
    final isDark = brightness == Brightness.dark;
    styleGuide ??= OCBaseStyleGuide();
    final logo = isDark
        ? 'assets/logo/logo-text-dark.png'
        : 'assets/logo/logo-text-light.png';
    colorTheme ??= isDark
        ? OCColorTheme.dark(styleGuide: styleGuide)
        : OCColorTheme.light(styleGuide: styleGuide);
    textTheme ??= isDark
        ? OCTextTheme.dark(styleGuide: styleGuide)
        : OCTextTheme.light(styleGuide: styleGuide);
    buttonTheme ??= isDark
        ? OCButtonTheme.dark(styleGuide: styleGuide)
        : OCButtonTheme.light(styleGuide: styleGuide);

    final defaultTheme = OctopusThemeData.fromTextTheme(
      logo,
      colorTheme,
      textTheme,
      buttonTheme,
      styleGuide,
    );
    return defaultTheme;
  }

  const OctopusThemeData.raw({
    required this.logo,
    required this.colorTheme,
    required this.textTheme,
    required this.buttonTheme,
    required this.styleGuide,
    required this.otherMessageTheme,
    required this.ownMessageTheme,
    required this.reactionIcons,
    required this.channelHeaderTheme,
    required this.channelPreviewThemeData,
  });

  factory OctopusThemeData.fromTextTheme(
    String logo,
    OCColorTheme colorTheme,
    OCTextTheme textTheme,
    OCButtonTheme buttonTheme,
    OCStyleGuide styleGuide,
  ) {
    final channelHeaderTheme = ChannelHeaderTheme(
      avatarTheme: AvatarThemeData(
        borderRadius: BorderRadius.circular(20),
        constraints: const BoxConstraints.tightFor(
          height: 35,
          width: 35,
        ),
      ),
      color: colorTheme.contentView,
      titleStyle: textTheme.primaryGreyH1,
      subtitleStyle: textTheme.primaryGreyFootnote.copyWith(
        color: const Color(0xff7A7A7A),
      ),
    );

    final channelPreviewTheme = ChannelPreviewThemeData(
      unreadCounterColor: colorTheme.errorBackgroundColor,
      avatarTheme: AvatarThemeData(
        borderRadius: BorderRadius.circular(30),
        constraints: const BoxConstraints.tightFor(
          height: 55,
          width: 55,
        ),
      ),
      titleStyle: textTheme.primaryGreyBodyBold,
      subtitleStyle: textTheme.primaryGreyBody.copyWith(
        color: const Color(0xff7A7A7A),
      ),
      lastMessageAtStyle: textTheme.primaryGreyFootnote.copyWith(
        color: colorTheme.primaryGrey.withOpacity(0.5),
      ),
      indicatorIconSize: 16,
    );
    return OctopusThemeData.raw(
      logo: logo,
      colorTheme: colorTheme,
      textTheme: textTheme,
      buttonTheme: buttonTheme,
      styleGuide: styleGuide,
      otherMessageTheme: OCMessageThemeData(
        messageAuthorStyle: textTheme.primaryGreyFootnote,
        messageTextStyle: textTheme.primaryGreyBody,
        messageBackgroundColor: colorTheme.contentView,
        messageBorderColor: colorTheme.border,
        createdAtStyle: textTheme.primaryGreyFootnote,
        reactionsBackgroundColor: colorTheme.contentView,
        reactionsBorderColor: colorTheme.border,
        reactionsMaskColor: colorTheme.contentView,
        avatarTheme: AvatarThemeData(
          borderRadius: BorderRadius.circular(20),
          constraints: const BoxConstraints.tightFor(
            height: 32,
            width: 32,
          ),
        ),
        linkBackgroundColor: colorTheme.link,
      ),
      ownMessageTheme: OCMessageThemeData(
        messageAuthorStyle: textTheme.primaryGreyFootnote,
        messageTextStyle: textTheme.primaryGreyBody.copyWith(
          color: styleGuide.primaryGrey.darkAppearance,
        ),
        messageBackgroundColor: colorTheme.brandPrimary,
        messageBorderColor: colorTheme.brandPrimary,
        createdAtStyle: textTheme.primaryGreyFootnote,
        reactionsBackgroundColor: colorTheme.contentView,
        reactionsBorderColor: colorTheme.border,
        reactionsMaskColor: colorTheme.contentView,
        avatarTheme: AvatarThemeData(
          borderRadius: BorderRadius.circular(20),
          constraints: const BoxConstraints.tightFor(
            height: 32,
            width: 32,
          ),
        ),
        linkBackgroundColor: colorTheme.link,
      ),
      reactionIcons: [
        ReactionIcon(
          type: 'love',
          builder: (context, highlighted, size) {
            final theme = OctopusTheme.of(context);
            return SvgPicture.asset(
              'assets/icons/love_reaction.svg',
              color: highlighted
                  ? theme.colorTheme.brandPrimarySelect
                  : theme.colorTheme.icon.withOpacity(0.5),
              width: size,
              height: size,
            );
          },
        ),
        ReactionIcon(
          type: 'like',
          builder: (context, highlighted, size) {
            final theme = OctopusTheme.of(context);
            return SvgPicture.asset(
              'assets/icons/thumbs_up_reaction.svg',
              color: highlighted
                  ? theme.colorTheme.brandPrimarySelect
                  : theme.colorTheme.icon.withOpacity(0.5),
              width: size,
              height: size,
            );
          },
        ),
        ReactionIcon(
          type: 'sad',
          builder: (context, highlighted, size) {
            final theme = OctopusTheme.of(context);
            return SvgPicture.asset(
              'assets/icons/thumbs_down_reaction.svg',
              color: highlighted
                  ? theme.colorTheme.brandPrimarySelect
                  : theme.colorTheme.icon.withOpacity(0.5),
              width: size,
              height: size,
            );
          },
        ),
        ReactionIcon(
          type: 'haha',
          builder: (context, highlighted, size) {
            final theme = OctopusTheme.of(context);
            return SvgPicture.asset(
              'assets/icons/LOL_reaction.svg',
              color: highlighted
                  ? theme.colorTheme.brandPrimarySelect
                  : theme.colorTheme.icon.withOpacity(0.5),
              width: size,
              height: size,
            );
          },
        ),
        ReactionIcon(
          type: 'wow',
          builder: (context, highlighted, size) {
            final theme = OctopusTheme.of(context);
            return SvgPicture.asset(
              'assets/icons/wut_reaction.svg',
              color: highlighted
                  ? theme.colorTheme.brandPrimarySelect
                  : theme.colorTheme.icon.withOpacity(0.5),
              width: size,
              height: size,
            );
          },
        ),
      ],
      channelHeaderTheme: channelHeaderTheme,
      channelPreviewThemeData: channelPreviewTheme,
    );
  }

  OctopusThemeData copyWith({
    String? logo,
    OCColorTheme? colorTheme,
    OCTextTheme? textTheme,
    OCButtonTheme? buttonTheme,
    OCStyleGuide? styleGuide,
    OCMessageThemeData? otherMessageTheme,
    OCMessageThemeData? ownMessageTheme,
    List<ReactionIcon>? reactionIcons,
    ChannelHeaderTheme? channelHeaderTheme,
    ChannelPreviewThemeData? channelPreviewThemeData,
  }) =>
      OctopusThemeData.raw(
        logo: logo ?? this.logo,
        colorTheme: colorTheme ?? this.colorTheme,
        textTheme: textTheme ?? this.textTheme,
        buttonTheme: buttonTheme ?? this.buttonTheme,
        styleGuide: styleGuide ?? this.styleGuide,
        otherMessageTheme: otherMessageTheme ?? this.otherMessageTheme,
        ownMessageTheme: ownMessageTheme ?? this.ownMessageTheme,
        reactionIcons: reactionIcons ?? this.reactionIcons,
        channelHeaderTheme: channelHeaderTheme ?? this.channelHeaderTheme,
        channelPreviewThemeData:
            channelPreviewThemeData ?? this.channelPreviewThemeData,
      );

  OctopusThemeData merge(OctopusThemeData? other) {
    if (other == null) return this;
    return copyWith();
  }
}
