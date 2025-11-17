import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarm_event.dart';
part 'alarm_state.dart';
part 'alarm_bloc.freezed.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  AlarmBloc() : super(_Initial()) {
    on<AlarmEvent>((event, emit) {});
  }
}
