import '../bloc/creator_bloc.dart';
import 'package:flutter/material.dart';
import '../../data/models/models.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/options/options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/core/routes/routes.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/core/constants/const_data.dart';
import 'package:reminder/utils/theme/responsive_size.dart';
import '../../../settings/widgets/custom_menu_item_card.dart';
import 'package:reminder/core/constants/enums/remind_type.dart';
import 'package:reminder/utils/extension/string_extension.dart';
import 'package:reminder/core/UI/widgets/simple_app_button.dart';
import '../../../../core/UI/screens/custom_backgraund_style.dart';

class SelectRemindTypeScreen extends StatefulWidget {
  const SelectRemindTypeScreen({super.key});

  @override
  State<SelectRemindTypeScreen> createState() => _SelectRemindTypeScreenState();
}

class _SelectRemindTypeScreenState extends State<SelectRemindTypeScreen> {
  List<RemindType> types = [
    RemindType.interval,
    RemindType.multiple,
    RemindType.weekly,
    RemindType.cyclic,
  ];

  @override
  void initState() {
    context.read<CreatorBloc>().add(CreatorEvent.started());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Select Remind Mode'.tr,
      backgroundColor: context.primaryColor,
      appBar: AppBar(
        leadingWidth: 60,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: Icon(CupertinoIcons.back, color: white, size: 32),
        ),
      ),

      body: BlocBuilder<CreatorBloc, CreatorState>(
        builder: (context, state) {
          return SizedBox(
            height: appSize.height * 0.81.w / 1.h,
            child: Column(
              spacing: spacingVal,
              children: [
                Column(
                  children: types
                      .map(
                        (type) => CustomMenuItemCard(
                          height: 60.h,
                          borderRadius: buttonborderRadVal.r,
                          spaceTitle: spacingVal * 1.5,
                          suffix: CupertinoSwitch(
                            activeColor: context.secondaryColor,
                            value: state.remind.type == type,
                            onChanged: (val) => context.read<CreatorBloc>().add(
                              CreatorEvent.updateData(
                                data: val ? getModel(type) : defaultModel,
                              ),
                            ),
                          ),
                          title: getTitle(type),
                          subtitle: getSubtitle(type),
                          margin: EdgeInsets.symmetric(
                            horizontal: paddingVal,
                            vertical: 5,
                          ).scaled,
                          padding: EdgeInsets.only(
                            top: verticalPadVal / 1.3,
                            bottom: verticalPadVal / 1.2,
                            right: paddingVal / 2,
                          ).scaled,
                          onTap: () => context.read<CreatorBloc>().add(
                            CreatorEvent.updateData(data: getModel(type)),
                          ),
                          bottomWidget: state.remind.type == type
                              ? getOptions(state.remind)
                              : SizedBox(),
                        ),
                      )
                      .toList(),
                ),

                const Spacer(),
                SimpleAppButton(
                  text: 'Next',
                  width: double.infinity,
                  bordercolor: context.borderColor,
                  textColor: state.remind.type != null
                      ? context.secondaryColor
                      : white,
                  splashColor: context.secondaryColor.withOpacity(0.15),
                  margin: EdgeInsets.symmetric(horizontal: horizantPadVal),
                  color: state.remind.type != null
                      ? white
                      : context.primaryColor,
                  onTap: state.remind.type == null
                      ? null
                      : () => Navigator.of(
                          context,
                        ).pushNamed(AppRouter.creatRemindScreen),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget getOptions(RemindModel remind) {
  return switch (remind.type) {
    RemindType.interval => IntervalOptions(
      remind: remind as IntervalRemindModel,
    ),
    RemindType.multiple => MultipleOptions(
      remind: remind as MultipleRemindModel,
    ),
    RemindType.weekly => WeeklyOptions(remind: remind as WeeklyRemindModel),
    RemindType.cyclic => CyclicOptions(remind: remind as CyclicRemindModel),
    null => const SizedBox(),
  };
}

String getTitle(RemindType type) {
  return switch (type) {
    // RemindType.interval => 'interval'.tr,
    // RemindType.multiple => 'multiple_daily'.tr,
    // RemindType.weekly => 'weekly'.tr,
    // RemindType.cyclic => 'cyclic_mode'.tr,
    RemindType.interval => 'Interval',
    RemindType.multiple => 'Multiple',
    RemindType.weekly => 'Weekly',
    RemindType.cyclic => 'Cyclic',
  };
}

String getSubtitle(RemindType type) {
  return switch (type) {
    RemindType.interval => 'interval_subtitle'.tr,
    RemindType.multiple => 'multiple_daily_subtitle'.tr,
    RemindType.weekly => 'weekly_subtitle'.tr,
    RemindType.cyclic => 'cyclic_mode_subtitle'.tr,
  };
}
