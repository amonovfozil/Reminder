import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../utils/theme/theme.dart';
import '../../../core/storage/app_storage.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:reminder/core/constants/const_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_event.dart';
part 'setting_state.dart';
part 'setting_bloc.freezed.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitState(theme: AppTheme.light)) {
    on<_Init>(_onInit);
    on<_SetFont>(_onSetFont);
    on<_SetColor>(_onSetColor);
    on<_SetSound>(_onSetSound);
    on<_ChangeLocale>(_onChangeLocale);
    on<_ToggleStatus>(_onToggleStatus);
  }

  // Functions
  void _onInit(_Init event, emit) {
    emit(
      SettingInitState(
        theme: state.theme.copyWith(
          primaryColor: AppStorage.themeColor,
          secondaryHeaderColor: AppStorage.themeSecondColor,
          textTheme: state.theme.textTheme.copyWith(
            bodyMedium: TextStyle(fontFamily: AppStorage.themeFont),
          ),
        ),
        noteStatus: AppStorage.noteStatus,
        noteSound: AppStorage.noteSound,
      ),
    );
  }

  Future<void> _onSetColor(_SetColor event, emit) async {
    emit(
      SettingInitState(
        theme: state.theme.copyWith(
          primaryColor: event.color,
          secondaryHeaderColor: event.secondary,
        ),
        noteStatus: state.noteStatus,
        noteSound: state.noteSound,
      ),
    );
    await AppStorage.writeThemeColor(event.color);
    await AppStorage.writeThemeSecondColor(event.secondary);
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
        noteStatus: state.noteStatus,
        noteSound: state.noteSound,
      ),
    );
    Navigator.of(event.ctx).maybePop();
    await AppStorage.writeThemeFont(event.font);
  }

  Future<void> _onSetSound(_SetSound event, emit) async {
    emit(
      SettingInitState(
        theme: state.theme,
        noteSound: event.sound,
        noteStatus: state.noteStatus,
      ),
    );
    Navigator.of(event.ctx).maybePop();
    await AppStorage.writeNoteSound(event.sound);
  }

  Future<void> _onToggleStatus(_ToggleStatus event, emit) async {
    emit(
      SettingInitState(
        theme: state.theme,
        noteSound: state.noteSound,
        noteStatus: event.status,
      ),
    );
    await AppStorage.writeNoteStatus(event.status);
  }

  void _onChangeLocale(_ChangeLocale event, emit) async {
    LocaleNotifier.of(event.ctx)?.change(event.code);
    Navigator.of(event.ctx).maybePop();
    await AppStorage.writeLocale(event.code);
    emit(SettingInitState(theme: state.theme, noteStatus: state.noteStatus));
  }
}
