import '../bloc/creator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../data/models/remind_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/theme/app_colors.dart';
import '../../../../core/constants/const_data.dart';
import '../../data/models/types/cyclic_remind.dart';
import '../../data/models/types/weekly_remind.dart';
import '../../../../utils/theme/responsive_size.dart';
import '../../data/models/types/interval_remind.dart';
import '../../data/models/types/multiple_remind.dart';
import '../widgets/options_body/cyclic_option_body.dart';
import '../widgets/options_body/weekly_option_body.dart';
import '../../../../utils/extension/string_extension.dart';
import '../widgets/options_body/interval_option_body.dart';
import '../widgets/options_body/multiple_option_body.dart';
import '../../../../core/UI/widgets/simple_app_button.dart';
import 'package:reminder/core/constants/enums/remind_type.dart';
import 'package:reminder/core/UI/widgets/custom_text_feild.dart';
import '../../../../core/UI/screens/custom_backgraund_style.dart';

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
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController noteCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // titleCtrl.clear();
    // noteCtrl.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocBuilder<CreatorBloc, CreatorState>(
        builder: (context, state) {
          // log("message ${state.remind.title}. type=${state.remind.type}");
          return CustomBackgraundStyle(
            title: 'New ${getTitle(state.remind.type)} Remind'.tr,
            scaffoldColor: context.primaryColor,
            leadingWidth: 60,
            leadingAppbar: IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: Icon(CupertinoIcons.back, color: white, size: 32),
            ),

            headBody: SizedBox(
              height: appSize.height * 0.85.w / 1.h,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 90),
                  child: Column(
                    spacing: spacingVal,
                    children: [
                      // CustomTextField(
                      //   hintText: 'Title',
                      //   cardColor: white,
                      //   margin: const EdgeInsets.symmetric(
                      //     horizontal: horizantPadVal,
                      //   ).scaled,
                      //   controller: TextEditingController(),
                      //   validator: (val) {},
                      // ),
                      // CustomTextField(
                      //   hintText: 'Note (Optional)',
                      //   minLines: 3,
                      //   cardColor: white,
                      //   margin: const EdgeInsets.symmetric(
                      //     horizontal: horizantPadVal,
                      //   ).scaled,
                      //   controller: TextEditingController(),
                      //   validator: (val) {},
                      // ),
                      Card(
                        color: white.withOpacity(1),
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
                            vertical: horizantPadVal,
                            horizontal: paddingVal,
                          ).scaled,
                          child: Column(
                            spacing: spacingVal,
                            children: [
                              CustomTextField(
                                initialval: state.remind.title,
                                hintText: 'Title',
                                controller: titleCtrl,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'is Empty';
                                  }
                                  return null;
                                },
                                onChanged: (val) =>
                                    context.read<CreatorBloc>().add(
                                      CreatorEvent.updateData(
                                        data: getCurrentModel(
                                          state.remind,
                                        ).copyWith(title: val),
                                      ),
                                    ),
                              ),
                              CustomTextField(
                                initialval: state.remind.body,
                                hintText: 'Note (Optional)',
                                minLines: 3,
                                controller: noteCtrl,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'is Empty';
                                  }
                                  return null;
                                },
                                onChanged: (val) =>
                                    context.read<CreatorBloc>().add(
                                      CreatorEvent.updateData(
                                        data: getCurrentModel(
                                          state.remind,
                                        ).copyWith(body: val),
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      getOptionBody(state.remind),
                      // RemindNoteStatusWidget(remind: state.remind),
                      // const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            bottomSheet: Padding(
              padding: EdgeInsets.only(
                left: horizantPadVal,
                right: horizantPadVal,
                top: horizantPadVal,
                bottom: paddingVal * 2,
              ).scaled,
              child: Row(
                spacing: spacingVal,
                children: [
                  Expanded(
                    child: SimpleAppButton(
                      text: 'creat',
                      width: double.infinity,
                      textColor: context.secondaryColor,
                      splashColor: context.secondaryColor.withOpacity(0.15),
                      color: white,
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<CreatorBloc>().add(CreatorEvent.creat());
                        }
                      },
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

getCurrentModel(RemindModel model) {
  return switch (model.type) {
    RemindType.interval => model as IntervalRemindModel,
    RemindType.multiple => model as MultipleRemindModel,
    RemindType.weekly => model as WeeklyRemindModel,
    RemindType.cyclic => model as CyclicRemindModel,
    null => model,
  };
}

Widget getOptionBody(RemindModel remind) {
  return switch (remind.type) {
    RemindType.interval => IntervalOptionBody(
      remind: remind as IntervalRemindModel,
    ),
    RemindType.multiple => MultipleOptionBody(
      remind: remind as MultipleRemindModel,
    ),
    RemindType.weekly => WeeklyOptionBody(remind: remind as WeeklyRemindModel),
    RemindType.cyclic => CyclicOptionBody(remind: remind as CyclicRemindModel),
    null => const SizedBox(),
  };
}

String getTitle(RemindType? type) {
  return switch (type) {
    RemindType.interval => 'Interval',
    RemindType.multiple => 'Multiple',
    RemindType.weekly => 'Weekly',
    RemindType.cyclic => 'Cyclic',
    null => '',
  };
}
