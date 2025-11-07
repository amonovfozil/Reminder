import '../bloc/setting_bloc.dart';
import 'custom_menu_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/const_data.dart';
import 'package:flutter_locales/flutter_locales.dart';

class LocalesModal extends StatefulWidget {
  const LocalesModal({super.key});

  @override
  State<LocalesModal> createState() => _LocalesModalState();
}

class _LocalesModalState extends State<LocalesModal> {
  List<String> locales = [uz, ru, en];
  @override
  Widget build(BuildContext context) {
    String? currentLocale = context.locales?.locale.languageCode;

    return Padding(
      padding: const EdgeInsets.only(bottom: paddingVal),
      child: Column(
        spacing: spacingVal,

        children: locales
            .map(
              (locale) => CustomMenuItemCard(
                title: localeName(locale),
                borderRadius: 20,
                spaceTitle: spacingVal * 2,
                isActive: currentLocale == locale,
                prefix: Image.asset(localeIcon(locale)),
                onTap: () => context.read<SettingBloc>().add(
                  SettingEvent.changeLocale(ctx: context, code: locale),
                ),
                suffix: SizedBox(),
              ),
            )
            .toList(),
      ),
    );
  }
}

String localeIcon(String? locale) {
  return switch (locale) {
    uz => 'assets/images/setting/uzbekistan.png',
    ru => 'assets/images/setting/russia.png',
    en => 'assets/images/setting/usa.png',
    _ => '',
  };
}

String localeName(String? locale) {
  return switch (locale) {
    uz => 'Uzbek',
    ru => 'Russian',
    en => 'English',
    _ => '',
  };
}
