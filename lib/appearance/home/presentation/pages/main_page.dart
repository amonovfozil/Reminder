import '../bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../settings/pages/settings_page.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/responsive_size.dart';
import 'package:reminder/core/UI/widgets/backgraund_font.dart';
import 'package:reminder/appearance/todo/presentation/pages/todo_page.dart';
import 'package:reminder/appearance/todo/presentation/bloc/todo_bloc.dart';
import 'package:reminder/appearance/todo/presentation/helpers/todo_helper.dart';
import 'package:reminder/appearance/todo/presentation/widgets/todo_task_editor_sheet.dart';
import 'package:reminder/appearance/statistics/presentation/pages/statistics_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pages = const [StatisticsPage(), TodoPage(), SettingsPage()];

  Future<void> _openTodoEditorFromNav() async {
    final todoBloc = context.read<TodoBloc>();
    final selectedDate = todoBloc.state.selectedDate;
    if (TodoHelper.isPast(selectedDate)) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: TodoTaskEditorSheet(
            selectedDate: selectedDate,
            typeOptions: TodoPage.typeOptions,
            onSave: (title, note, plannedAt, iconKey, typeLabel) {
              todoBloc.add(
                TodoAddOrUpdateTask(
                  title: title,
                  note: note,
                  plannedAt: plannedAt,
                  iconKey: iconKey,
                  typeLabel: typeLabel,
                ),
              );
              Navigator.of(ctx).pop();
            },
          ),
        );
      },
    );
  }

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
                Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: TabBarView(children: pages),
                ),
                Positioned(
                  bottom: 32.h,
                  child: CutomBottomNavigationBar(
                    onAddTodo: _openTodoEditorFromNav,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
