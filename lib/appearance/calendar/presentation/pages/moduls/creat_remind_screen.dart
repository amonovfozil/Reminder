import '../../bloc/creator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/remind_model.dart';
import '../../../../../utils/theme/app_colors.dart';
import '../../widgets/options/multiple_options.dart';
import '../../widgets/options/interval_options.dart';
import '../../../../../core/constants/const_data.dart';
import '../../../../../utils/theme/responsive_size.dart';
import '../../../data/models/types/multiple_remind.dart';
import '../../../data/models/types/interval_remind.dart';
import '../../../../../utils/extension/string_extension.dart';
import '../../../../../core/UI/widgets/simple_app_button.dart';
import 'package:reminder/core/constants/enums/remind_type.dart';
import 'package:reminder/core/UI/widgets/custom_text_feild.dart';
import '../../../../../core/UI/screens/custom_backgraund_style.dart';

class CreatRemindScreen extends StatefulWidget {
  const CreatRemindScreen({super.key});

  @override
  State<CreatRemindScreen> createState() => _CreatRemindScreenState();
}

class _CreatRemindScreenState extends State<CreatRemindScreen> {
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
    return CustomBackgraundStyle(
      title: 'New Remind'.tr,
      scaffoldColor: context.primaryColor,
      leadingWidth: 60,
      leadingAppbar: IconButton(
        onPressed: () => Navigator.of(context).maybePop(),
        icon: Icon(CupertinoIcons.back, color: white, size: 32),
      ),

      headBody: BlocBuilder<CreatorBloc, CreatorState>(
        builder: (context, state) {
          return SizedBox(
            height: appSize.height * 0.8.w / 1.h,
            child: Center(
              child: Column(
                spacing: spacingVal,
                children: [
                  Card(
                    color: white.withOpacity(1),
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    elevation: 1,
                    borderOnForeground: false,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: borderWidth,
                        color: context.borderColor.withOpacity(0.08),
                      ),
                      borderRadius: BorderRadius.circular(borderRadVal.r),
                    ),
                    child: Container(
                      width: appSize.width,
                      padding: EdgeInsets.symmetric(
                        vertical: horizantPadVal,
                        horizontal: paddingVal,
                      ).scaled,
                      child: Column(
                        spacing: spacingVal,
                        children: [
                          CustomTextField(
                            hintText: 'Title',
                            controller: TextEditingController(),
                            validator: (val) {},
                          ),
                          CustomTextField(
                            hintText: 'Note (Optional)',
                            minLines: 3,
                            controller: TextEditingController(),
                            validator: (val) {},
                          ),
                          SizedBox(
                            height: 95,
                            child: GridView.count(
                              padding: EdgeInsets.only(top: 0),
                              crossAxisCount: 2,
                              childAspectRatio: 4.w / (1.0.h),
                              mainAxisSpacing: spacingVal / 2,
                              crossAxisSpacing: spacingVal / 2,
                              children: types
                                  .map(
                                    (type) => SimpleAppButton(
                                      text: getTitle(type),
                                      height: 40,
                                      width: double.infinity,

                                      bordercolor: borderColor,
                                      color: state.remind.type == type
                                          ? context.primaryColor
                                          : Colors.transparent,
                                      textColor: state.remind.type == type
                                          ? white
                                          : context.primaryColor,
                                      borderRadius: 10.r,
                                      // borderRadius: iteamCardborderRadVal,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 14,
                                      ).scaled,
                                      // style: context.subTitleTextStyle.copyWith(
                                      //   color: white,
                                      //   fontSize: 11.sp,
                                      // ),
                                      onTap: () =>
                                          context.read<CreatorBloc>().add(
                                            CreatorEvent.updateData(
                                              data: getModel(type),
                                            ),
                                          ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Visibility(
                    visible: state.remind.type != null,
                    child: state.remind.type == RemindType.interval
                        ? IntervalOptions(
                            remind: state.remind as IntervalRemindModel,
                          )
                        : state.remind.type == RemindType.multiple
                        ? MultipleOptions(
                            remind: state.remind as MultipleRemindModel,
                          )
                        : SizedBox(),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: horizantPadVal,
                    ),
                    child: Row(
                      spacing: spacingVal,
                      children: [
                        Expanded(
                          child: SimpleAppButton(
                            text: 'creat',
                            width: double.infinity,
                            textColor: context.secondaryColor,
                            splashColor: context.secondaryColor.withOpacity(
                              0.15,
                            ),
                            color: white,
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          child: SimpleAppButton(
                            text: 'clear',
                            width: double.infinity,
                            textColor: context.secondaryColor,
                            splashColor: context.secondaryColor.withOpacity(
                              0.15,
                            ),
                            color: white,
                            onTap: () => context.read<CreatorBloc>().add(
                              CreatorEvent.updateData(data: defaultModel),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

RemindModel getModel(RemindType type) {
  return switch (type) {
    RemindType.interval => intervalModel,
    RemindType.multiple => multipleRemindModel,
    RemindType.weekly => defaultModel,
    RemindType.cyclic => defaultModel,
  };
}

String getTitle(RemindType type) {
  return switch (type) {
    RemindType.interval => 'Interval',
    RemindType.multiple => 'Multiple',
    RemindType.weekly => 'Weekly',
    RemindType.cyclic => 'Cyclic',
  };
}
