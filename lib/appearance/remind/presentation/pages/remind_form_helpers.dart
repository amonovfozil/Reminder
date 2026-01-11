import 'package:flutter/widgets.dart';
import 'package:reminder/core/constants/enums/remind_type.dart';
import 'package:reminder/appearance/remind/data/models/remind_model.dart';
import 'package:reminder/appearance/remind/data/models/types/cyclic_remind.dart';
import 'package:reminder/appearance/remind/data/models/types/weekly_remind.dart';
import 'package:reminder/appearance/remind/data/models/types/interval_remind.dart';
import 'package:reminder/appearance/remind/data/models/types/multiple_remind.dart';
import 'package:reminder/appearance/remind/presentation/widgets/options_body/cyclic_option_body.dart';
import 'package:reminder/appearance/remind/presentation/widgets/options_body/weekly_option_body.dart';
import 'package:reminder/appearance/remind/presentation/widgets/options_body/interval_option_body.dart';
import 'package:reminder/appearance/remind/presentation/widgets/options_body/multiple_option_body.dart';
import 'package:reminder/appearance/remind/presentation/widgets/options/cyclic_options.dart';
import 'package:reminder/appearance/remind/presentation/widgets/options/weekly_options.dart';
import 'package:reminder/appearance/remind/presentation/widgets/options/interval_options.dart';
import 'package:reminder/appearance/remind/presentation/widgets/options/multiple_options.dart';
import 'package:reminder/utils/extension/string_extension.dart';

dynamic getCurrentModel(RemindModel model) {
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

Widget getTypeOptions(RemindModel remind, {bool useBottomSheet = false}) {
  return switch (remind.type) {
    RemindType.interval => IntervalOptions(
      remind: remind as IntervalRemindModel,
      useBottomSheet: useBottomSheet,
    ),
    RemindType.multiple => MultipleOptions(
      remind: remind as MultipleRemindModel,
      useBottomSheet: useBottomSheet,
    ),
    RemindType.weekly => WeeklyOptions(remind: remind as WeeklyRemindModel),
    RemindType.cyclic => CyclicOptions(
      remind: remind as CyclicRemindModel,
      useBottomSheet: useBottomSheet,
    ),
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

String getSubtitle(RemindType type) {
  return switch (type) {
    RemindType.interval => 'interval_subtitle'.tr,
    RemindType.multiple => 'multiple_daily_subtitle'.tr,
    RemindType.weekly => 'weekly_subtitle'.tr,
    RemindType.cyclic => 'cyclic_mode_subtitle'.tr,
  };
}
