import 'package:flutter_bloc/flutter_bloc.dart';
import '../../appearance/home/presentation/bloc/home_bloc.dart';
import 'package:reminder/appearance/settings/bloc/setting_bloc.dart';
import 'package:reminder/appearance/remind/presentation/bloc/creator_bloc.dart';
import 'package:reminder/appearance/todo/presentation/bloc/todo_bloc.dart';

List<BlocProvider> blocProviders = [
  //Home
  BlocProvider<HomeBloc>(create: (context) => HomeBloc()),

  //Calendar
  BlocProvider<CreatorBloc>(create: (context) => CreatorBloc()),

  // Settings
  BlocProvider<SettingBloc>(
    create: (context) => SettingBloc()..add(SettingEvent.init()),
  ),

  // Todo
  BlocProvider<TodoBloc>(create: (context) => TodoBloc()),
];
