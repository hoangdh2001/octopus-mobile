import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octopus/core/data/client/client.dart';
import 'package:octopus/core/data/models/user.dart';
import 'package:octopus/core/theme/oc_theme.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:octopus/pages/settings/bloc/settings_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.client});

  final Client client;

  @override
  State<SettingsPage> createState() => SettingsPageState();

  static SettingsPageState of(BuildContext context) {
    SettingsPageState? octopusState;

    octopusState = context.findAncestorStateOfType<SettingsPageState>();

    if (octopusState == null) {
      throw Exception(
        'You must have a Octopus widget at the top of your widget tree',
      );
    }

    return octopusState;
  }
}

class SettingsPageState extends State<SettingsPage> {
  Client get client => widget.client;

  User get currentUser => widget.client.state.currentUser!;

  @override
  void initState() {
    getIt<SettingsBloc>().add(const FetchInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: MediaQuery.of(context).padding.bottom + 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 0.9.sw,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20).r,
              color: OctopusTheme.of(context).colorTheme.contentView,
            ),
            child: BlocBuilder<SettingsBloc, SettingsState>(
              bloc: getIt<SettingsBloc>(),
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Settings',
                          style: OctopusTheme.of(context)
                              .textTheme
                              .primaryGreyBodyBold,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset('assets/icons/close.svg')),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ...state.section.fold(
                      () => [Container()],
                      (section) {
                        return section;
                      },
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
