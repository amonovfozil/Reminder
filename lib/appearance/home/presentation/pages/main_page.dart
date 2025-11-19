import '../bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../settings/pages/settings_page.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/responsive_size.dart';
import 'package:reminder/core/UI/widgets/backgraund_font.dart';
import 'package:reminder/appearance/home/presentation/pages/home_page.dart';
import 'package:reminder/appearance/calendar/presentation/pages/calendar_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pages = const [
    HomePage(),
    // AlarmsPage(),
    CalendarPage(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return DefaultTabController(
          length: pages.length,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            // extendBody: true,
            backgroundColor: context.scaffoldColor,
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                BackgraundFont(),
                TabBarView(children: pages),
                Positioned(bottom: 32.h, child: CutomBottomNavigationBar()),
              ],
            ),
          ),
        );
      },
    );
  }
}
