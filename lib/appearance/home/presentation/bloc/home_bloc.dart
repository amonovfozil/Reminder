import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialHomeState()) {
    on<_Init>(_onInit);
    on<_SwitchScreen>(_onSwitchScreen);
  }

  //Functions
  void _onInit(_Init event, emit) => emit(InitialHomeState(currentIndex: 0));

  void _onSwitchScreen(_SwitchScreen event, emit) =>
      emit(ContuneHomeState(currentIndex: event.index));

      
}
