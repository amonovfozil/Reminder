import '../bloc/setting_bloc.dart';
import 'custom_menu_item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/const_data.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';

class FontsModal extends StatefulWidget {
  const FontsModal({super.key});

  @override
  State<FontsModal> createState() => _FontsModalState();
}

class _FontsModalState extends State<FontsModal> {
  List<String> fonts = [poppins, roboto, montserrat, ptSans, playfair, ubuntu];
  @override
  Widget build(BuildContext context) {
    String? currentFont = context.subStyle.fontFamily;

    return Padding(
      padding: const EdgeInsets.only(bottom: paddingVal),
      child: Column(
        spacing: spacingVal,
        children: fonts
            .map(
              (font) => CustomMenuItemCard(
                title: fontName(font),
                borderRadius: 20,
                spaceTitle: spacingVal * 2,
                isActive: currentFont == font,
                prefix: getFontIcon(ctx: context, fontFamily: font),
                onTap: () => context.read<SettingBloc>().add(
                  SettingEvent.setFont(ctx: context, font: font),
                ),
                suffix: currentFont == font
                    ? Icon(
                        CupertinoIcons.check_mark_circled,
                        color: white,
                        size: 32,
                      )
                    : SizedBox(),
              ),
            )
            .toList(),
      ),
    );
  }
}

Widget getFontIcon({
  required BuildContext ctx,
  String? fontFamily,
  bool isActive = true,
}) {
  var currentFont = ctx.subStyle.fontFamily;
  return Container(
    height: isActive ? 45 : 35,
    width: isActive ? 45 : 35,
    decoration: BoxDecoration(
      border: Border.all(
        width: borderWidth,
        color: isActive && currentFont == fontFamily ? white : black,
      ),
      borderRadius: BorderRadius.circular(isActive ? 12 : 8),
    ),
    alignment: Alignment.center,
    child: Text(
      fontIcon(fontFamily),
      style: ctx.subTitleTextStyle.copyWith(
        fontFamily: fontFamily,
        color: isActive && currentFont == fontFamily ? white : black,
      ),
    ),
  );
}

String fontIcon(String? fontFamily) {
  return switch (fontFamily) {
    poppins => 'Pp',
    roboto => 'Rb',
    montserrat => 'Ms',
    ptSans => 'PS',
    playfair => 'Pf',
    ubuntu => 'Ub',
    _ => '',
  };
}

String fontName(String? fontFamily) {
  return switch (fontFamily) {
    poppins => 'Poppins',
    roboto => 'Roboto',
    montserrat => 'Montserrat',
    ptSans => 'PT Sans Narrow',
    playfair => 'Playfair Display',
    ubuntu => 'Ubuntu',
    _ => '',
  };
}
