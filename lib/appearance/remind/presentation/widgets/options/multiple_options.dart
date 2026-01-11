import '../../bloc/creator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import '../../../../../core/constants/const_data.dart';
import '../../../data/models/types/multiple_remind.dart';
import '../../../../../utils/theme/responsive_size.dart';
import '../../../../../utils/extension/string_extension.dart';
import '../../../../../core/UI/widgets/simple_app_button.dart';

class MultipleOptions extends StatefulWidget {
  const MultipleOptions({
    super.key,
    required this.remind,
    this.useBottomSheet = false,
  });
  final MultipleRemindModel remind;
  final bool useBottomSheet;

  @override
  State<MultipleOptions> createState() => MultipleOptionsState();
}

class MultipleOptionsState extends State<MultipleOptions> {
  static late FixedExtentScrollController scrollController;

  List<int> intervalValues = List.generate(10, (index) => (1 + index));
  @override
  void initState() {
    scrollController = FixedExtentScrollController(initialItem: 0);
    super.initState();
  }

  static jumpToIndex(int index) {
    scrollController.animateToItem(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: widget.useBottomSheet ? 0 : spacingVal,
      children: [
        Container(
          width: appSize.width,
          padding: EdgeInsets.only(
            bottom: widget.useBottomSheet ? 0 : verticalPadVal / 2,
            right: horizantPadVal,
            left: horizantPadVal,
          ),
          child: Column(
            spacing: spacingVal,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text('amount_'.tr, style: context.subTitleTextStyle),
                  const Spacer(),
                  SimpleAppButton(
                    text: widget.remind.amount.toString(),
                    onTap: () {
                      if (widget.useBottomSheet) {
                        context.read<CreatorBloc>().add(
                          CreatorEvent.updateData(
                            data: widget.remind.copyWith(enable: true),
                          ),
                        );
                        _showAmountPicker(context);
                        return;
                      }
                      context.read<CreatorBloc>().add(
                        CreatorEvent.updateData(
                          data: widget.remind.copyWith(
                            enable: !widget.remind.enable,
                          ),
                        ),
                      );
                    },
                    height: 22.h,
                    width: 22.w,
                    color: widget.remind.enable ? context.primaryColor : white,
                    textColor: widget.remind.enable
                        ? white
                        : context.primaryColor,
                    borderRadius: 7,
                    bordercolor: context.primaryColor,
                    padding: EdgeInsets.all(3).scaled,
                    margin: EdgeInsets.only(right: 5).scaled,
                    // style: context.subTitleTextStyle.copyWith(
                    //   color: white,
                    //   fontSize: 11.sp,
                    // ),
                  ),
                  Text(
                    'times_daily'.tr.replaceAll('X', ''),
                    style: context.subStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
        Visibility(
          visible: widget.remind.enable,
          child:
              widget.useBottomSheet
                  ? const SizedBox()
                  : Container(
                    width: appSize.width,
                    padding: EdgeInsets.symmetric(
                      // vertical: paddingVal,
                      // horizontal: horizantPadVal,
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
                                  amount: intervalValues[index],
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

  void _showAmountPicker(BuildContext context) {
    final currentIndex = intervalValues.indexOf(widget.remind.amount);
    final controller = FixedExtentScrollController(
      initialItem: currentIndex < 0 ? 0 : currentIndex,
    );
    showModalBottomSheet(
      context: context,
      backgroundColor: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(borderRadVal.r),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: 220.h,
          child: CupertinoPicker(
            itemExtent: 35,
            scrollController: controller,
            children: intervalValues
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(top: 6).scaled,
                    child: Text(
                      e.toString(),
                      textAlign: TextAlign.start,
                      style: context.titleTextStyle.copyWith(),
                    ),
                  ),
                )
                .toList(),
            onSelectedItemChanged: (index) =>
                context.read<CreatorBloc>().add(
                  CreatorEvent.updateData(
                    data: widget.remind.copyWith(
                      amount: intervalValues[index],
                    ),
                  ),
                ),
          ),
        );
      },
    );
  }
}
