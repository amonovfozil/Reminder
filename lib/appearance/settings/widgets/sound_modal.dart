import '../bloc/setting_bloc.dart';
import 'custom_menu_item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/const_data.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/extension/string_extension.dart';

class SoundModal extends StatefulWidget {
  const SoundModal({super.key});

  @override
  State<SoundModal> createState() => _SoundModalState();
}

class _SoundModalState extends State<SoundModal> {
  List<String> sounds = [custom, ringTon, radial, breaking, challet, melody];
  @override
  Widget build(BuildContext context) {
    // String? currentSound = context.subStyle.fontFamily;

    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        String currentSound = state.noteSound;
        return Padding(
          padding: const EdgeInsets.only(bottom: paddingVal),
          child: Column(
            spacing: spacingVal,
            children: sounds
                .map(
                  (sound) => CustomMenuItemCard(
                    title: sound.capitalizeFirst,
                    borderRadius: 20,
                    spaceTitle: spacingVal * 2,
                    isActive: currentSound == sound,
                    prefix: ImageIcon(
                      AssetImage('assets/images/setting/sound.png'),
                      color: currentSound == sound
                          ? white
                          : context.primaryColor,
                      size: cardMarginVal,
                    ),
                    onTap: () => context.read<SettingBloc>().add(
                      SettingEvent.setSound(ctx: context, sound: sound),
                    ),
                    suffix: currentSound == sound
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
      },
    );
  }
}
