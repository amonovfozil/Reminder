import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/appearance/remind/presentation/bloc/creator_bloc.dart';
import 'package:reminder/appearance/remind/presentation/pages/remind_form_helpers.dart';
import 'package:reminder/core/constants/const_data.dart';
import 'package:reminder/core/constants/enums/remind_type.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/responsive_size.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import 'package:reminder/core/UI/widgets/simple_app_button.dart';
import 'package:reminder/appearance/remind/data/models/remind_model.dart';

class RepeatConfigSheet extends StatefulWidget {
  const RepeatConfigSheet({super.key, required this.remind});

  final RemindModel remind;

  @override
  State<RepeatConfigSheet> createState() => _RepeatConfigSheetState();
}

class _RepeatConfigSheetState extends State<RepeatConfigSheet> {
  final List<RemindType> _types = const [
    RemindType.interval,
    RemindType.multiple,
    RemindType.weekly,
    RemindType.cyclic,
  ];

  RemindModel _mapType(RemindType type, RemindModel source) {
    final RemindModel mapped = getModel(type);
    mapped.id = source.id;
    mapped.title = source.title;
    mapped.body = source.body;
    mapped.enableAlert = source.enableAlert;
    mapped.remindMe = source.remindMe;
    mapped.isPaused = source.isPaused;
    mapped.notificationIds = source.notificationIds;
    return mapped;
  }

  @override
  void initState() {
    super.initState();
    context.read<CreatorBloc>().add(CreatorEvent.updateData(data: widget.remind));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatorBloc, CreatorState>(
      builder: (context, state) {
        final remind =
            state.remind.id == widget.remind.id ? state.remind : widget.remind;

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(borderRadVal.r),
              ),
            ),
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: marginVal.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 42.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: context.borderColor.withOpacity(0.55),
                          borderRadius: BorderRadius.circular(99.r),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Repeat',
                        style: context.subTitleTextStyle.copyWith(
                          color: context.primaryColor,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        padding: EdgeInsets.all(6).scaled,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(
                            buttonborderRadVal.r,
                          ),
                          border: Border.all(
                            width: borderWidth,
                            color: context.borderColor.withOpacity(0.12),
                          ),
                        ),
                        child: CupertinoSlidingSegmentedControl<RemindType>(
                          groupValue: remind.type ?? _types.first,
                          thumbColor: context.secondaryColor,
                          backgroundColor: Colors.transparent,
                          children: Map.fromEntries(
                            _types.map(
                              (type) => MapEntry(
                                type,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ).scaled,
                                  child: Text(
                                    getTitle(type),
                                    style: context.subTitleTextStyle.copyWith(
                                      fontSize: 12.sp,
                                      color: (remind.type ?? _types.first) ==
                                              type
                                          ? white
                                          : context.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onValueChanged: (type) {
                            if (type == null) return;
                            context.read<CreatorBloc>().add(
                              CreatorEvent.updateData(
                                data: _mapType(type, remind),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10.h),
                      getTypeOptions(remind, useBottomSheet: true),
                      getOptionBody(remind),
                      SizedBox(height: 12.h),
                      SimpleAppButton(
                        text: 'Apply',
                        width: double.infinity,
                        borderRadius: borderRadVal.r,
                        color: context.primaryColor,
                        textColor: white,
                        splashColor: white.withOpacity(0.12),
                        onTap: () =>
                            context.read<CreatorBloc>().add(CreatorEvent.creat()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

