import 'package:flutter_bloc/flutter_bloc.dart';
import '../../appearance/home/presentation/bloc/home_bloc.dart';
import 'package:reminder/appearance/settings/bloc/setting_bloc.dart';

List<BlocProvider> blocProviders = [
  //Home
  BlocProvider<HomeBloc>(create: (context) => HomeBloc()),

  // Settings
  BlocProvider<SettingBloc>(
    create: (context) => SettingBloc()..add(SettingEvent.init()),
  ),
];
