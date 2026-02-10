import 'package:flutter/material.dart';

import '../../../utils/theme/text_styles.dart';
import '../widgets/backgraund_font.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? drawerScrimColor;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final bool withBackGround;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  // Snow configuration
  final bool snowfallEnabled;
  final double snowOpacityFactor;

  const CustomScaffold({
    super.key,
    this.appBar,
    this.body,
    this.title = "",
    this.actions = const [],
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.withBackGround = true,
    this.scaffoldKey,
    this.snowfallEnabled = true,
    this.snowOpacityFactor = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    // Snow falls behind the UI only (no flakes over content).
    return
    // Scaffold(
    //   extendBody: true,
    //   body:
    Material(
      color: backgroundColor,
      child: Stack(
        children: [
          if (withBackGround)
            Positioned.fill(child: BackgraundFont(color: backgroundColor)),
          Scaffold(
            
            key: scaffoldKey,
            appBar:
                appBar ??
                AppBar(
                  backgroundColor: Colors.transparent,
                  title: Text(
                    title.toUpperCase(),
                    style: context.headerTextStyle,
                  ),
                  actions: actions,
                ),
            body: body,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: floatingActionButtonLocation,
            floatingActionButtonAnimator: floatingActionButtonAnimator,
            persistentFooterButtons: persistentFooterButtons,
            drawer: drawer,
            endDrawer: endDrawer,
            drawerScrimColor: drawerScrimColor,
            drawerEdgeDragWidth: drawerEdgeDragWidth,
            drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
            endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
            bottomNavigationBar: bottomNavigationBar,
            bottomSheet: bottomSheet,

            backgroundColor: Colors.transparent,
            // backgroundColor: backgroundColor ?? Colors.transparent,
            extendBody: extendBody,
            extendBodyBehindAppBar: extendBodyBehindAppBar,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            primary: primary,
          ),
        ],
      ),
    );
  }
}
