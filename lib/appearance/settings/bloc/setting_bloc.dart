import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../core/storage/app_storage.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/theme/theme.dart';

part 'setting_event.dart';
part 'setting_state.dart';
part 'setting_bloc.freezed.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitState(theme: AppTheme.light)) {
    on<_Init>(_onInit);
    on<_SetColor>(_onSetColor);
    on<_SetFont>(_onSetFont);
    on<_ChangeLocale>(_onChangeLocale);
  }

  // Functions
  void _onInit(_Init event, emit) {
    emit(
      SettingInitState(
        theme: state.theme.copyWith(
          brightness: AppStorage.appThemeMode.contains('dark')
              ? Brightness.dark
              : Brightness.light,
        ),
        statusNote: state.statusNote,
      ),
    );
  }

  Future<void> _onSetColor(_SetColor event, emit) async {
    emit(
      SettingInitState(
        theme: state.theme.copyWith(primaryColor: event.color),
        statusNote: state.statusNote,
      ),
    );
    // await AppStorage.writeThemeMode(event.mode.name);
  }

  Future<void> _onSetFont(_SetFont event, emit) async {
    emit(
      SettingInitState(
        // theme: state.theme,
        theme: state.theme.copyWith(
          textTheme: state.theme.textTheme.copyWith(
            bodyMedium: TextStyle(fontFamily: event.font),
          ),
        ),
        statusNote: state.statusNote,
      ),
    );
    // await AppStorage.writeThemeMode(event.mode.name);
  }

  void _onChangeLocale(_ChangeLocale event, emit) async {
    LocaleNotifier.of(event.ctx)?.change(event.code);
    await AppStorage.writeLocale(event.code);
    emit(SettingInitState(theme: state.theme, statusNote: state.statusNote));
  }
}
