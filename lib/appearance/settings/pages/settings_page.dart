import 'package:flutter/material.dart';
import '../../../utils/theme/app_colors.dart';
import '../widgets/custom_menu_item_card.dart';
import '../../../core/constants/const_data.dart';
import 'package:reminder/core/routes/routes.dart';
import '../../../core/UI/screens/custom_backgraund_style.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgraundStyle(
      title: 'Settings',
      headBody: Card(
        elevation: 1,
        color: white.withOpacity(0.90),
        margin: const EdgeInsets.symmetric(horizontal: 32),
        borderOnForeground: false,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: borderWidth,
            color: context.borderColor.withOpacity(0.08),
          ),
          borderRadius: BorderRadius.circular(borderRadVal),
        ),

        child: Container(
          height: appSize.height / 1.45,
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spacingVal,
            children: [
              CustomMenuItemCard(
                title: "Display thema",
                // subtitle: 'color',
                borderRadius: 20,
                prefix: ImageIcon(
                  AssetImage('assets/images/setting/category.png'),
                  color: context.primaryColor,
                  size: 32,
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRouter.displayThemePage),
              ),
              CustomMenuItemCard(
                title: "Language",
                // subtitle: 'color',
                borderRadius: 20,
                prefix: ImageIcon(
                  AssetImage('assets/images/setting/lang_2.png'),
                  color: context.primaryColor,
                  size: 32,
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRouter.languagePage),
              ),
              CustomMenuItemCard(
                title: "Notification",
                // subtitle: 'color',
                borderRadius: 20,
                prefix: ImageIcon(
                  AssetImage('assets/images/setting/bell.png'),
                  color: context.primaryColor,
                  size: 32,
                ),
                onTap: () => Navigator.of(
                  context,
                ).pushNamed(AppRouter.notificationsPage),
              ),
              CustomMenuItemCard(
                title: "Abaut app",
                // subtitle: 'color',
                borderRadius: 20,
                prefix: ImageIcon(
                  AssetImage('assets/images/setting/info.png'),
                  color: context.primaryColor,
                  size: 32,
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRouter.abautAppPage),
              ),
              SizedBox(height: 20, width: double.infinity),
            ],
          ),
        ),
      ),
      body: Column(
        spacing: spacingVal,
        children: [
          SizedBox(height: 20, width: double.infinity),
          // SizedBox(height: bottomHeightVal),
        ],
      ),
    );
  }
}
