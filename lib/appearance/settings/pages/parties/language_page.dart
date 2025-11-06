import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import '../../../../utils/theme/app_colors.dart';
import '../../widgets/custom_menu_item_card.dart';
import '../../../../core/constants/const_data.dart';
import '../../../../core/UI/screens/custom_backgraund_style.dart';
import 'package:reminder/appearance/settings/bloc/setting_bloc.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    String? currentLocale = context.locales?.locale.languageCode;
    return CustomBackgraundStyle(
      title: 'Language',
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
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 32),
          child: Column(
            spacing: spacingVal,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomMenuItemCard(
                title: "Uzbek",
                // subtitle: 'color',
                isActive: currentLocale == 'uz',

                borderRadius: 20,
                prefix: Image.asset(
                  'assets/images/setting/uzbekistan.png',
                  // height: 40,
                ),
                onTap: () => context.read<SettingBloc>().add(
                  SettingEvent.changeLocale(ctx: context, code: 'uz'),
                ),
                suffix: SizedBox(),
              ),
              CustomMenuItemCard(
                title: "Russian",
                // subtitle: 'color',
                isActive: currentLocale == 'ru',

                borderRadius: 20,
                prefix: Image.asset(
                  'assets/images/setting/russia.png',
                  // size: 32,
                ),
                suffix: SizedBox(),
                onTap: () => context.read<SettingBloc>().add(
                  SettingEvent.changeLocale(ctx: context, code: 'ru'),
                ),
              ),
              CustomMenuItemCard(
                title: "EngLish",
                isActive: currentLocale == 'en',
                // subtitle: 'color',
                borderRadius: 20,
                prefix: Image.asset(
                  'assets/images/setting/usa.png',
                  // size: 32,
                ),
                onTap: () => context.read<SettingBloc>().add(
                  SettingEvent.changeLocale(ctx: context, code: 'en'),
                ),
                suffix: SizedBox(),
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
