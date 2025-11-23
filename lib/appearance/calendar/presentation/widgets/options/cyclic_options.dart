import '../../bloc/creator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/theme/app_colors.dart';
import '../../../data/models/types/cyclic_remind.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import '../../../../../core/constants/const_data.dart';
import '../../../../../utils/theme/responsive_size.dart';
import '../../../../../utils/extension/string_extension.dart';
import '../../../../../core/UI/widgets/simple_app_button.dart';

class CyclicOptions extends StatefulWidget {
  const CyclicOptions({super.key, required this.remind});
  final CyclicRemindModel remind;

  @override
  State<CyclicOptions> createState() => _CyclicOptionsState();
}

class _CyclicOptionsState extends State<CyclicOptions> {
  List<int> intervalValues = List.generate(90 - 2 + 1, (index) => (2 + index));
  late FixedExtentScrollController scrollController;
  @override
  void initState() {
    scrollController = FixedExtentScrollController(initialItem: 0);
    super.initState();
  }

  void jumpToIndex(int index) {
    scrollController.animateToItem(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: spacingVal,
      children: [
        Card(
          color: white.withOpacity(0.90),
          margin: const EdgeInsets.symmetric(horizontal: horizantPadVal).scaled,
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
              vertical: paddingVal,
              horizontal: horizantPadVal,
            ),
            child: Column(
              spacing: spacingVal.w / 2.h,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 3,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('cyclic_mode'.tr, style: context.titleTextStyle),
                          Text(
                            'cyclic_mode_subtitle'.tr,
                            style: context.subStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(height: 2, color: context.secondaryColor),
                Row(
                  children: [
                    Text('amount_'.tr, style: context.subTitleTextStyle),
                    const Spacer(),
                    SimpleAppButton(
                      text: widget.remind.activeVal.toString(),
                      onTap: () {
                        context.read<CreatorBloc>().add(
                          CreatorEvent.updateData(
                            data: widget.remind.copyWith(enableInterval: 1),
                          ),
                        );
                        WidgetsBinding.instance.addPostFrameCallback(
                          (_) => jumpToIndex(
                            intervalValues.indexOf(widget.remind.activeVal),
                          ),
                        );
                      },
                      height: 22.h,
                      width: 22.w,
                      color: widget.remind.enableInterval == 1
                          ? context.primaryColor
                          : white,
                      textColor: widget.remind.enableInterval == 1
                          ? white
                          : context.primaryColor,
                      borderRadius: 7,
                      fontSize: 12,
                      bordercolor: context.secondaryColor,
                      padding: EdgeInsets.all(3).scaled,
                      margin: EdgeInsets.only(right: 5).scaled,
                    ),
                    Text('day'.tr.replaceAll('X', ''), style: context.subStyle),
                  ],
                ),
                Row(
                  children: [
                    Text('pouse_day'.tr, style: context.subTitleTextStyle),
                    const Spacer(),
                    SimpleAppButton(
                      text: widget.remind.pauseVal.toString(),
                      onTap: () {
                        context.read<CreatorBloc>().add(
                          CreatorEvent.updateData(
                            data: widget.remind.copyWith(enableInterval: 2),
                          ),
                        );
                        WidgetsBinding.instance.addPostFrameCallback(
                          (_) => jumpToIndex(
                            intervalValues.indexOf(widget.remind.pauseVal),
                          ),
                        );
                      },
                      height: 22.h,
                      width: 22.w,
                      color: widget.remind.enableInterval == 2
                          ? context.primaryColor
                          : white,
                      textColor: widget.remind.enableInterval == 2
                          ? white
                          : context.primaryColor,
                      borderRadius: 7,
                      fontSize: 12,
                      bordercolor: context.secondaryColor,
                      padding: EdgeInsets.all(3).scaled,
                      margin: EdgeInsets.only(right: 5).scaled,
                    ),
                    Text('day'.tr.replaceAll('X', ''), style: context.subStyle),
                  ],
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: widget.remind.enableInterval != 0,
          child: Card(
            color: white.withOpacity(0.90),
            margin: const EdgeInsets.symmetric(
              horizontal: horizantPadVal,
            ).scaled,
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
                // vertical: paddingVal,
                horizontal: horizantPadVal,
              ).scaled,
              child: SizedBox(
                height: 160.w / 1.h,
                child: CupertinoPicker(
                  itemExtent: 35,
                  scrollController: scrollController,
                  children: intervalValues
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(top: 6).scaled,
                          child: Text(
                            e.toString(),
                            textAlign: TextAlign.start,
                            style: context.titleTextStyle.copyWith(
                              // fontSize: 20,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onSelectedItemChanged: (index) =>
                      context.read<CreatorBloc>().add(
                        CreatorEvent.updateData(
                          data: widget.remind.copyWith(
                            activeVal: widget.remind.enableInterval == 1
                                ? intervalValues[index]
                                : widget.remind.activeVal,
                            pauseVal: widget.remind.enableInterval == 2
                                ? intervalValues[index]
                                : widget.remind.pauseVal,
                          ),
                        ),
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
