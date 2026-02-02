import 'package:flutter/material.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/core/constants/const_data.dart';
import 'package:reminder/utils/theme/responsive_size.dart';

class CustomBottomNavigationBarItem {
  final String? title;
  final String iconPath;
  final Function? function;

  CustomBottomNavigationBarItem({
    this.title,
    required this.iconPath,
    this.function,
  });
}

List<CustomBottomNavigationBarItem> menu = [
  CustomBottomNavigationBarItem(iconPath: "assets/images/home/home.png"),
  CustomBottomNavigationBarItem(iconPath: "assets/images/home/calendar.png"),
  CustomBottomNavigationBarItem(iconPath: "assets/images/home/settings.png"),
];

class CutomBottomNavigationBar extends StatefulWidget {
  final VoidCallback? onAddTodo;

  const CutomBottomNavigationBar({super.key, this.onAddTodo});

  @override
  State<CutomBottomNavigationBar> createState() =>
      _CutomBottomNavigationBarState();
}

class _CutomBottomNavigationBarState extends State<CutomBottomNavigationBar> {
  static const Duration _addDelay = Duration(milliseconds: 1400);
  TabController? _controller;
  bool _showAddDelayed = false;
  bool _isWaiting = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final nextController = DefaultTabController.of(context);
    if (_controller == nextController) return;
    _controller?.removeListener(_handleTabChange);
    _controller = nextController;
    _controller?.addListener(_handleTabChange);
    _syncInitialState();
  }

  @override
  void dispose() {
    _controller?.removeListener(_handleTabChange);
    super.dispose();
  }

  void _syncInitialState() {
    _showAddDelayed = false;
    _isWaiting = false;
    _startDelayIfTodo();
  }

  void _handleTabChange() {
    if (!mounted || _controller == null) return;
    _startDelayIfTodo();
  }

  void _startDelayIfTodo() {
    final isTodo = _controller?.index == 1;
    if (!isTodo) {
      _isWaiting = false;
      if (_showAddDelayed) {
        setState(() => _showAddDelayed = false);
      }
      return;
    }

    if (_showAddDelayed || _isWaiting) return;
    _isWaiting = true;
    Future.delayed(_addDelay, () {
      if (!mounted) return;
      _isWaiting = false;
      if (_controller?.index == 1) {
        setState(() => _showAddDelayed = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = DefaultTabController.of(context);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final currentIndex = controller.index;
        final isTodo = currentIndex == 1;
        final showAdd = _showAddDelayed;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: marginVal).scaled,
          child: SizedBox(
            width: appSize.width - 70.w,
            height: 140.h,
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadVal.r),
                    color: context.secondaryColor,
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorAnimation: TabIndicatorAnimation.elastic,
                    padding: EdgeInsets.all(5).scaled,
                    labelPadding: EdgeInsets.zero,
                    indicatorWeight: 0,
                    dividerHeight: 0,
                    splashFactory: NoSplash.splashFactory,
                    indicator: BoxDecoration(
                      color: showAdd
                          ? Colors.transparent
                          : context.primaryColor,
                      borderRadius: BorderRadius.circular(borderRadVal.r),
                    ),
                    overlayColor: WidgetStatePropertyAll(
                      context.secondaryColor,
                    ),
                    onTap: (index) {
                      if (index == 1 && isTodo && showAdd) {
                        widget.onAddTodo?.call();
                      }
                    },
                    tabs: [
                      Tab(
                        child: ImageIcon(
                          AssetImage(menu[0].iconPath),
                          color: white,
                          size: 28.w,
                        ),
                      ),
                      Tab(
                        child: showAdd
                            ? const SizedBox.shrink()
                            : _buildCenterTab(context, showAdd),
                      ),
                      Tab(
                        child: ImageIcon(
                          AssetImage(menu[2].iconPath),
                          color: white,
                          size: 28.w,
                        ),
                      ),
                    ],
                  ),
                ),
                if (showAdd)
                  Positioned(
                    bottom: 10.h,
                    child: GestureDetector(
                      onTap: widget.onAddTodo,
                      child: _buildAddBubble(context),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCenterTab(BuildContext context, bool showAdd) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      switchInCurve: Curves.easeOutBack,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: showAdd
          ? const SizedBox.shrink()
          : ImageIcon(
              key: const ValueKey('calendar'),
              AssetImage(menu[1].iconPath),
              color: white,
              size: 28.w,
            ),
    );
  }

  Widget _buildAddBubble(BuildContext context) {
    return Container(
      key: const ValueKey('add'),
      width: 60.w,
      height: 60.w,
      decoration: BoxDecoration(
        color: white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.14),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: context.primaryColor.withOpacity(0.25),
            blurRadius: 18,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(Icons.add, color: context.primaryColor, size: 40.w),
    );
  }
}
