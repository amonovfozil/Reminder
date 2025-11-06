import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../widgets/custom_font_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/theme/app_colors.dart';
import '../../../../core/constants/const_data.dart';
import '../../../../core/UI/screens/custom_backgraund_style.dart';
import 'package:reminder/appearance/settings/bloc/setting_bloc.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgraundStyle(
      title: 'Notification',
      appbar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 60,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: Icon(CupertinoIcons.back, color: white, size: 32),
        ),
      ),
      headBody: Card(
        color: white.withOpacity(0.90),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        elevation: 1,
        borderOnForeground: false,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: borderWidth,
            color: context.borderColor.withOpacity(0.08),
          ),
          borderRadius: BorderRadius.circular(borderRadVal),
        ),
        child: Container(
          height: appSize.height / 1.35,
          padding: const EdgeInsets.symmetric(horizontal: paddingVal),
          child: Column(
            children: [
              CustomFontCard(
                color: Colors.red,
                secondaryColor: Colors.redAccent,
                title: 'Red',
                onSelect: (color, secondary) => context.read<SettingBloc>().add(
                  SettingEvent.setColor(color: color!, secondary: secondary!),
                ),
              ),
              CustomFontCard(
                color: Colors.green,
                secondaryColor: Colors.lightGreen,

                title: 'Green',
                onSelect: (color, secondary) => context.read<SettingBloc>().add(
                  SettingEvent.setColor(color: color!, secondary: secondary!),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        spacing: spacingVal,
        children: [SizedBox(height: 20, width: double.infinity)],
      ),
    );
  }
}
