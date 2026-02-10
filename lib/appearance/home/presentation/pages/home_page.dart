import 'package:flutter/material.dart';
import '../../../../core/routes/routes.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/core/storage/app_storage.dart';
import 'package:reminder/core/constants/const_data.dart';
import '../../../../utils/extension/string_extension.dart';
import 'package:reminder/utils/theme/responsive_size.dart';
import '../../../../core/UI/widgets/custom_card_button.dart';
import '../../../../core/UI/screens/custom_backgraund_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      withBackGround: false,
      title: 'Reminder',
      actions: [
        IconButton(
          icon: Icon(Icons.add, size: 30, color: white),
          onPressed: () =>
              Navigator.of(context).pushNamed(AppRouter.selectRemindTypeScreen),
        ),
      ],
      // headBody: NowRemindCard(),
      body: SingleChildScrollView(
        child: Column(
          spacing: spacingVal.h,
          children: [
            SizedBox(height: 40.h),
            Column(
              children: AppStorage.reminders
                  .map(
                    (elm) => CustomCardButton(
                      title: elm.title,
                      // subtitle: (elm as IntervalRemindModel).times
                      //     .map((time) => Formatter.timeFormat(time))
                      //     .toList()
                      //     .join(', '),
                      // subtitle: (elm as IntervalRemindModel).isHourly
                      // .toString(),
                      subtitle: elm.type?.name.capitalizeFirst ?? '',
                      // subtitle: '03 June, 2024  07:00PM',
                      margin: EdgeInsets.only(
                        bottom: 10,
                        left: marginVal,
                        right: marginVal,
                      ).scaled,
                      suffix: ImageIcon(
                        AssetImage('assets/images/home/users.png'),
                        color: context.primaryColor,
                        size: 32.w,
                      ),
                      onTap: () => Navigator.of(
                        context,
                      ).pushNamed(AppRouter.editRemindScreen, arguments: elm),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: bottomHeightVal.h),
          ],
        ),
      ),
    );
  }
}
