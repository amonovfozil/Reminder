import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/utils/theme/text_styles.dart';
import '../../../../core/constants/const_data.dart';
import 'package:reminder/core/constants/enums/remind_type.dart';
import '../../../../core/UI/widgets/custom_text_feild.dart';
import '../../../../core/UI/widgets/simple_app_button.dart';
import '../../../../core/UI/screens/custom_backgraund_style.dart';
import '../../../../utils/extension/string_extension.dart';
import '../../../../utils/theme/app_colors.dart';
import '../../../../utils/theme/responsive_size.dart';
import '../../data/models/remind_model.dart';
import '../bloc/creator_bloc.dart';
import 'remind_form_helpers.dart';

class EditRemindScreen extends StatefulWidget {
  const EditRemindScreen({super.key, required this.remind});

  final RemindModel remind;

  @override
  State<EditRemindScreen> createState() => _EditRemindScreenState();
}

class _EditRemindScreenState extends State<EditRemindScreen> {
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController noteCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<RemindType> types = [
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
    return mapped;
  }

  @override
  void initState() {
    titleCtrl.text = widget.remind.title;
    noteCtrl.text = widget.remind.body;
    context.read<CreatorBloc>().add(
      CreatorEvent.updateData(data: widget.remind),
    );
    super.initState();
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocBuilder<CreatorBloc, CreatorState>(
        builder: (context, state) {
          final remind = state.remind.id == widget.remind.id
              ? state.remind
              : widget.remind;
          return CustomBackgraundStyle(
            title: 'Edit ${getTitle(remind.type)} Remind'.tr,
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
                      Card(
                        color: white.withOpacity(1),
                        margin: const EdgeInsets.symmetric(
                          horizontal: horizantPadVal,
                          vertical: 6,
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: verticalPadVal / 1.5,
                            horizontal: 2,
                          ).scaled,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ).scaled,
                                child: Container(
                                  padding: const EdgeInsets.all(4).scaled,
                                  decoration: BoxDecoration(
                                    color: white.withOpacity(0.95),
                                    borderRadius: BorderRadius.circular(
                                      buttonborderRadVal.r,
                                    ),
                                    border: Border.all(
                                      width: borderWidth,
                                      color: context.borderColor.withOpacity(
                                        0.08,
                                      ),
                                    ),
                                  ),
                                  child:
                                      CupertinoSlidingSegmentedControl<
                                        RemindType
                                      >(
                                        groupValue: remind.type ?? types.first,
                                        thumbColor: context.secondaryColor,
                                        backgroundColor: Colors.transparent,
                                        children: Map.fromEntries(
                                          types.map(
                                            (type) => MapEntry(
                                              type,
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 6,
                                                    ).scaled,
                                                child: Text(
                                                  getTitle(type),
                                                  style: context
                                                      .subTitleTextStyle
                                                      .copyWith(
                                                        color:
                                                            (remind.type ??
                                                                    types
                                                                        .first) ==
                                                                type
                                                            ? white
                                                            : context
                                                                  .primaryColor,
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
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: verticalPadVal / 1.5,
                                ).scaled,
                                child: Divider(
                                  height: 0,
                                  color: context.borderColor,
                                ),
                              ),
                              getTypeOptions(remind, useBottomSheet: true),
                            ],
                          ),
                        ),
                      ),
                      getOptionBody(remind),
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
                                          remind,
                                        ).copyWith(title: val),
                                      ),
                                    ),
                              ),
                              CustomTextField(
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
                                          remind,
                                        ).copyWith(body: val),
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                      text: 'save',
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
