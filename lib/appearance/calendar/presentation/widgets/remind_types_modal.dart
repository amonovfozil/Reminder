import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/const_data.dart';
import 'package:reminder/utils/theme/responsive_size.dart';
import '../../../../core/constants/enums/remind_type.dart';
import '../../../../utils/extension/string_extension.dart';
import '../../../settings/widgets/custom_menu_item_card.dart';
import 'package:reminder/appearance/calendar/data/models/remind_model.dart';
import 'package:reminder/appearance/calendar/presentation/bloc/creator_bloc.dart';

class RemindTypesModal extends StatefulWidget {
  const RemindTypesModal({super.key});

  @override
  State<RemindTypesModal> createState() => _RemindTypesModalState();
}

class _RemindTypesModalState extends State<RemindTypesModal> {
  List<RemindType> types = [
    RemindType.interval,
    RemindType.multiple,
    RemindType.weekly,
    RemindType.cyclic,
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: paddingVal,
        left: marginVal,
        right: marginVal,
      ),

      child: Column(
        spacing: spacingVal,
        children: types
            .map(
              (type) => CustomMenuItemCard(
                height: 65,
                borderRadius: 20,
                spaceTitle: spacingVal * 1.5,
                title: getTitle(type),
                subtitle: getSubtitle(type),
                margin: EdgeInsets.all(0).scaled,
                padding: EdgeInsets.symmetric(
                  vertical: verticalPadVal / 2,
                ).scaled,
                onTap: () {
                  context.read<CreatorBloc>().add(
                    CreatorEvent.updateData(data: getModel(type)),
                  );
                  // Navigator.of(context).pushNamed(AppRouter.intervalModuls);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

String getTitle(RemindType type) {
  return switch (type) {
    RemindType.interval => 'interval'.tr,
    RemindType.multiple => 'multiple_daily'.tr,
    RemindType.weekly => '',
    RemindType.cyclic => '',
  };
}

String getSubtitle(RemindType type) {
  return switch (type) {
    RemindType.interval => 'interval_subtitle'.tr,
    RemindType.multiple => 'multiple_daily_subtitle'.tr,
    RemindType.weekly => '',
    RemindType.cyclic => '',
  };
}

RemindModel getModel(RemindType type) {
  return switch (type) {
    RemindType.interval => intervalModel,
    RemindType.multiple => multipleRemindModel,
    RemindType.weekly => defaultModel,
    RemindType.cyclic => defaultModel,
  };
}
