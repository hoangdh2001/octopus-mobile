import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:octopus/pages/settings/section/settings_section_factory.dart';
import 'package:octopus/utils/constants.dart';

part 'settings_bloc.freezed.dart';

enum SettingSection {
  general,
  logout;
}

@singleton
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsSectionFactory sectionFactory;
  final FlutterSecureStorage secureStorage;
  SettingsBloc(this.sectionFactory, this.secureStorage)
      : super(SettingsState.initial()) {
    on<SettingsEvent>((event, emit) async {
      await event.map(fetchInitial: (value) async {
        emit(state.copyWith(
            section: some(SettingSection.values
                .map((section) => sectionFactory.createSection(section))
                .toList())));
      });
    });
  }

  Future<void> handleRemoveToken() async {
    await secureStorage.delete(key: octopusToken);
  }
}

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.fetchInitial() = FetchInitial;
}

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required Option<List<Widget>> section,
  }) = _SettingsState;

  factory SettingsState.initial() => SettingsState(section: none());
}
