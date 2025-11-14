
import '../bloc/setting_bloc.dart';
import '../widgets/fonts_modal.dart';
import 'package:flutter/material.dart';
import '../widgets/locales_modal.dart';
import 'package:flutter/cupertino.dart';
import '../../../utils/theme/app_colors.dart';
import '../widgets/custom_menu_item_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/const_data.dart';
import 'package:reminder/core/routes/routes.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:reminder/core/helpers/helper.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../core/UI/screens/custom_backgraund_style.dart';
import 'package:reminder/utils/extension/string_extension.dart';
import 'package:reminder/core/constants/secrets/app_secrets.dart';
import 'package:reminder/appearance/settings/widgets/sound_modal.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String version = '';

  @override
  void initState() {
    getAppInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? currentLocale = context.locales?.locale.languageCode;
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        return CustomBackgraundStyle(
          title: 'Settings',
          headBody: SizedBox(
            height: appSize.height / 1.42,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 1,
                  color: white.withOpacity(0.90),
                  margin: const EdgeInsets.symmetric(horizontal: cardMarginVal),
                  borderOnForeground: false,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: borderWidth,
                      color: context.borderColor.withOpacity(0.08),
                    ),
                    borderRadius: BorderRadius.circular(borderRadVal),
                  ),

                  child: Container(
                    // height: appSize.height / 1.45,
                    // height: 4iteamCardBorderRadVal,
                    padding: const EdgeInsets.symmetric(
                      vertical: cardMarginVal,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spacingVal,
                      children: [
                        CustomMenuItemCard(
                          title: "Display thema",
                          borderRadius: iteamCardBorderRadVal,
                          padding: const EdgeInsets.only(
                            left: horizantPadVal,
                            bottom: verticalPadVal,
                            top: verticalPadVal,
                            right: paddingVal,
                          ),
                          prefix: ImageIcon(
                            AssetImage('assets/images/setting/catalog.png'),
                            color: context.primaryColor,
                            size: cardIconSize,
                          ),
                          onTap: () => Navigator.of(
                            context,
                          ).pushNamed(AppRouter.displayThemePage),
                        ),
                        CustomMenuItemCard(
                          title: "Notification",
                          borderRadius: iteamCardBorderRadVal,
                          padding: const EdgeInsets.only(
                            left: horizantPadVal,
                            bottom: verticalPadVal,
                            top: verticalPadVal,
                            right: paddingVal,
                          ),
                          prefix: ImageIcon(
                            AssetImage('assets/images/setting/bell.png'),
                            color: context.primaryColor,
                            size: cardMarginVal,
                          ),

                          suffix: CupertinoSwitch(
                            activeColor: context.secondaryColor,
                            value: state.noteStatus,
                            onChanged: (status) => context
                                .read<SettingBloc>()
                                .add(SettingEvent.togglestatus(status: status)),
                          ),
                        ),
                        CustomMenuItemCard(
                          title: "Alarm sound",
                          borderRadius: iteamCardBorderRadVal,
                          prefix: ImageIcon(
                            AssetImage('assets/images/setting/sound.png'),
                            color: context.primaryColor,
                            size: cardIconSize,
                          ),
                          suffix: Text(
                            state.noteSound,
                            style: context.subStyle.copyWith(color: black),
                          ),
                          onTap: () => Helper.showBottomModel(
                            ctx: context,
                            body: SoundModal(),
                            title: "Select Sound",
                          ),
                        ),
                        CustomMenuItemCard(
                          title: "Language",
                          borderRadius: iteamCardBorderRadVal,
                          prefix: ImageIcon(
                            AssetImage('assets/images/setting/lang.png'),
                            color: context.primaryColor,
                            size: cardIconSize,
                          ),
                          suffix: Image.asset(
                            localeIcon(currentLocale),
                            height: cardIconSize,
                          ),
                          onTap: () => Helper.showBottomModel(
                            ctx: context,
                            body: LocalesModal(),
                            title: "Select Locale",
                          ),
                        ),
                        CustomMenuItemCard(
                          title: "Font",
                          borderRadius: iteamCardBorderRadVal,
                          prefix: ImageIcon(
                            AssetImage('assets/images/setting/font.png'),
                            color: context.primaryColor,
                            size: cardIconSize,
                          ),
                          suffix: Text(
                            fontName(context.subStyle.fontFamily),
                            style: context.subStyle.copyWith(color: black),
                          ),

                          onTap: () => Helper.showBottomModel(
                            ctx: context,
                            body: FontsModal(),
                            title: "Select Font Family",
                          ),
                        ),
                        CustomMenuItemCard(
                          title: "Rated",
                          borderRadius: iteamCardBorderRadVal,
                          prefix: ImageIcon(
                            AssetImage('assets/images/setting/rating.png'),
                            color: context.primaryColor,
                            size: cardMarginVal,
                          ),
                          suffix: SizedBox(),
                          onTap: () async {
                            final InAppReview inAppReview =
                                InAppReview.instance;
                            if (await inAppReview.isAvailable()) {
                              inAppReview.requestReview();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),
                Center(
                  child: Text(
                    "app_version".tr.replaceAll('1.0.12', version),
                    style: context.subStyle.copyWith(color: white, height: 1.4),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async =>
                          await launchUrl(Uri.parse(AppSecrets.telegrambUrl)),
                      icon: Icon(Icons.telegram, color: white, size: 26),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: ImageIcon(
                        AssetImage('assets/images/setting/instagram.png'),
                        color: white,
                        size: 24,
                      ),
                    ),

                    IconButton(
                      onPressed: () async =>
                          await launchUrl(Uri.parse(AppSecrets.gitHubUrl)),
                      icon: ImageIcon(
                        AssetImage('assets/images/setting/github.png'),
                        color: white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: SizedBox(),
        );
      },
    );
  }

  void getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version.isEmpty ? '1.0.0' : packageInfo.version;
    });
  }
}
