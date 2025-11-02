import 'utils/theme/theme.dart';
import 'core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'core/constants/const_data.dart';
import 'core/providers/bloc_providers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'appearance/settings/bloc/setting_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'appearance/home/presentation/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['ru', 'en', 'uz']);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          return LocaleBuilder(
            builder: (locale) => MaterialApp(
              title: 'Reminder app',
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRouter.generateRoute,
              themeMode: state.mode,
              theme: AppTheme.light(context),
              darkTheme: AppTheme.dark(context),
              locale: locale,
              localizationsDelegates: Locales.delegates,
              supportedLocales: Locales.supportedLocales,
              home: const MainPage(),
            ),
          );
        },
      ),
    );
  }
}
