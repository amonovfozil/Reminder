import '../../../settings/pages/settings_page.dart';
import '../bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/appearance/home/presentation/pages/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pages = [
    const HomePage(),
    Container(color: Colors.blueAccent),
    const SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          // extendBody: true,
          backgroundColor: context.scaffoldColor,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: pages[state.currentIndex],
              ),
              Positioned(
                bottom: 32,
                child: CutomBottomNavigationBar(
                  currentIndex: state.currentIndex,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
