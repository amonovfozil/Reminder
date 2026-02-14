import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:reminder/appearance/remind/data/models/models.dart';
import 'package:reminder/appearance/remind/presentation/widgets/repeat_config_sheet.dart';
import '../../../../core/routes/routes.dart';
import 'package:reminder/core/notifications/local_notifications_service.dart';
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
  String _repeatIndicator(RemindModel remind) {
    if (remind is IntervalRemindModel) {
      if (remind.isHourly) {
        return 'Interval ${_formatHours(remind.interval)}';
      }
      return 'Interval ${remind.interval.ceil()}d';
    }
    if (remind is MultipleRemindModel) {
      final times = remind.times.length;
      return 'Multiple ${times}x/day';
    }
    if (remind is WeeklyRemindModel) {
      return 'Weekly';
    }
    if (remind is CyclicRemindModel) {
      return 'Cyclic ${remind.activeVal}/${remind.pauseVal}';
    }
    return remind.type?.name.capitalizeFirst ?? '';
  }

  String _formatHours(double hours) {
    final minutes = (hours * 60).round();
    if (minutes <= 0) return '${hours.toStringAsFixed(1)}h';
    if (minutes < 60) return '${minutes}m';
    if (minutes % 60 == 0) return '${minutes ~/ 60}h';
    final h = minutes ~/ 60;
    final m = minutes % 60;
    return '${h}h${m}m';
  }

  Future<void> _openCreate() async {
    await Navigator.of(context).pushNamed(AppRouter.selectRemindTypeScreen);
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _openEdit(RemindModel remind) async {
    await Navigator.of(
      context,
    ).pushNamed(AppRouter.editRemindScreen, arguments: remind);
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _openRepeat(RemindModel remind) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => RepeatConfigSheet(remind: remind),
    );
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _confirmDelete(RemindModel remind) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Delete reminder?'),
          content: Text('“${remind.title}” will be deleted.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    await LocalNotificationsService.instance.cancelForReminder(remind);
    final next = AppStorage.reminders.where((e) => e.id != remind.id).toList();
    await AppStorage.write.reminders(next);
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final reminders = AppStorage.reminders;
    return CustomScaffold(
      withBackGround: false,
      title: 'Reminder',
      actions: [
        IconButton(
          icon: Icon(Icons.add, size: 30, color: white),
          onPressed: _openCreate,
        ),
      ],
      // headBody: NowRemindCard(),
      body: SingleChildScrollView(
        child: Column(
          spacing: spacingVal.h,
          children: [
            SizedBox(height: 40.h),
            Column(
              children: reminders.map(_buildReminderItem).toList(),
            ),
            SizedBox(height: bottomHeightVal.h),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderItem(RemindModel remind) {
    final margin = EdgeInsets.only(
      bottom: 10,
      left: marginVal,
      right: marginVal,
    ).scaled;

    return Padding(
      padding: margin,
      child: Slidable(
        key: ValueKey(remind.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.72,
          children: [
            SlidableAction(
              onPressed: (_) async => _openEdit(remind),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
            SlidableAction(
              onPressed: (_) async => _confirmDelete(remind),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (_) async => _openRepeat(remind),
              backgroundColor: context.secondaryColor,
              foregroundColor: Colors.white,
              icon: Icons.timer,
              label: 'Repeat',
            ),
          ],
        ),
        child: CustomCardButton(
          title: remind.title,
          subtitle: _repeatIndicator(remind),
          margin: EdgeInsets.zero,
          suffix: ImageIcon(
            AssetImage('assets/images/home/users.png'),
            color: context.primaryColor,
            size: 32.w,
          ),
          onTap: () async => _openEdit(remind),
        ),
      ),
    );
  }
}
