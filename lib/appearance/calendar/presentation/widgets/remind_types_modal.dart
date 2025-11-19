import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:reminder/core/UI/widgets/simple_app_button.dart';
import 'package:reminder/utils/theme/responsive_size.dart';
import '../../../../core/constants/const_data.dart';
import '../pages/moduls/interval/interval_type_card.dart';
import '../../../../core/constants/enums/remind_type.dart';
import '../pages/moduls/multiply/multiply_type_card.dart';

class RemindTypesModal extends StatefulWidget {
  const RemindTypesModal({super.key});

  @override
  State<RemindTypesModal> createState() => _RemindTypesModalState();
}

class _RemindTypesModalState extends State<RemindTypesModal> {
  List<RemindType> types = [
    RemindType.interval,
    RemindType.multiple,
    RemindType.week,
    RemindType.cyclic,
  ];
  @override
  Widget build(BuildContext context) {
    // String? currentFont = context.subStyle.fontFamily;

    return Padding(
      padding: const EdgeInsets.only(
        bottom: paddingVal,
        left: marginVal,
        right: marginVal,
      ),

      child: Column(
        spacing: spacingVal,
        children: [
          IntervalTypeCard(),
          MultiplyTypeCard(),
          SimpleAppButton(
            text: 'creat',
            margin: EdgeInsets.only(top: cardMarginVal).scaled,
          ),
        ],
      ),
    );
  }
}
