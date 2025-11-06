import 'package:flutter_bloc/flutter_bloc.dart';
import '../../appearance/home/presentation/bloc/home_bloc.dart';
import 'package:reminder/appearance/settings/bloc/setting_bloc.dart';
import 'package:reminder/appearance/calendar/presentation/bloc/calendar_bloc.dart';

List<BlocProvider> blocProviders = [
  //Home
  BlocProvider<HomeBloc>(create: (context) => HomeBloc()),

  //Calendar
  BlocProvider<CalendarBloc>(create: (context) => CalendarBloc()),

  // Settings
  BlocProvider<SettingBloc>(
    create: (context) => SettingBloc()..add(SettingEvent.init()),
  ),
];
