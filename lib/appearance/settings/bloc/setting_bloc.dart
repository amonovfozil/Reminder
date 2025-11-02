import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../core/storage/app_storage.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_event.dart';
part 'setting_state.dart';
part 'setting_bloc.freezed.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitState()) {
    on<_Init>(_onInit);
    on<_ChangeMode>(_onChangeMode);
    on<_ChangeLocale>(_onChangeLocale);
  }

  // Functions
  void _onInit(_Init event, emit) {
    emit(
      SettingInitState(
        mode: AppStorage.appThemeMode.contains('dark')
            ? ThemeMode.dark
            : ThemeMode.light,
        statusNote: state.statusNote,
      ),
    );
  }

  Future<void> _onChangeMode(_ChangeMode event, emit) async {
    emit(SettingInitState(mode: event.mode, statusNote: state.statusNote));
    await AppStorage.writeThemeMode(event.mode.name);
  }

  void _onChangeLocale(_ChangeLocale event, emit) async {
    LocaleNotifier.of(event.ctx)?.change(event.code);
    await AppStorage.writeLocale(event.code);
    emit(SettingInitState(mode: state.mode, statusNote: state.statusNote));
  }
}
