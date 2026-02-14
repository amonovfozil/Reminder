import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reminder/appearance/todo/data/models/todo_day_model.dart';
import 'package:reminder/appearance/todo/presentation/bloc/todo_bloc.dart';
import 'package:reminder/appearance/todo/presentation/helpers/todo_helper.dart';
import 'package:reminder/core/UI/screens/custom_backgraund_style.dart';
import 'package:reminder/core/constants/const_data.dart';
import 'package:reminder/core/storage/app_storage.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/responsive_size.dart';
import 'package:reminder/utils/theme/text_styles.dart';

enum StatisticsPeriod { yearly, monthly, weekly }

extension on StatisticsPeriod {
  String get label => switch (this) {
    StatisticsPeriod.yearly => 'Yillik',
    StatisticsPeriod.monthly => 'Oylik',
    StatisticsPeriod.weekly => 'Haftalik',
  };

  bool get isScrollable => this != StatisticsPeriod.weekly;
}

enum StatisticsTaskFilter { done, late, notDone }

extension on StatisticsTaskFilter {
  String get label => switch (this) {
    StatisticsTaskFilter.done => 'Bajarilgan',
    StatisticsTaskFilter.late => 'Kechiktirilgan',
    StatisticsTaskFilter.notDone => 'Bajarilmagan',
  };

  Color get color => switch (this) {
    StatisticsTaskFilter.done => const Color(0xFF2EC27E),
    StatisticsTaskFilter.late => const Color(0xFFF2C94C),
    StatisticsTaskFilter.notDone => const Color(0xFFEB5757),
  };
}

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  static const _chartCardColor = Color(0xFFFF4B2B);
  static const _chartTrackColor = Color(0xA33B1F19);

  StatisticsPeriod _period = StatisticsPeriod.weekly;
  StatisticsTaskFilter _filter = StatisticsTaskFilter.done;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, todoState) {
        final today = TodoHelper.onlyDate(DateTime.now());
        final buckets = _buildBuckets(_period, todoState.days, today);
        final series = _buildSeries(todoState.days, buckets);
        final values = _valuesByFilter(series, _filter);
        final totals = _totals(series);
        final percents = _toPercents(totals);

        return CustomScaffold(
          withBackGround: false,
          backgroundColor: Colors.transparent,
          appBar: const PreferredSize(
            preferredSize: Size.zero,
            child: SizedBox.shrink(),
          ),
          body: Padding(
            padding: EdgeInsets.only(
              left: 4.w,
              right: 4.w,
              top: MediaQuery.paddingOf(context).top + 6.h,
              bottom: spacingVal.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PeriodSelector(
                  value: _period,
                  onChanged: (next) => setState(() => _period = next),
                ),
                SizedBox(height: 14.h),
                _StatisticsChartCard(
                  title: '${_filter.label} statistikasi',
                  labels: buckets.map((bucket) => bucket.label).toList(),
                  values: values,
                  color: _filter.color,
                  cardColor: _chartCardColor,
                  trackColor: _chartTrackColor,
                  scrollable: _period.isScrollable,
                ),
                SizedBox(height: 14.h),
                _FilterSelector(
                  value: _filter,
                  onChanged: (next) => setState(() => _filter = next),
                ),
                SizedBox(height: 14.h),
                _PercentCards(
                  selectedFilter: _filter,
                  donePercent: percents.done,
                  latePercent: percents.late,
                  notDonePercent: percents.notDone,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PeriodSelector extends StatelessWidget {
  final StatisticsPeriod value;
  final ValueChanged<StatisticsPeriod> onChanged;

  const _PeriodSelector({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < StatisticsPeriod.values.length; i++) ...[
          Expanded(
            child: _PillButton(
              label: StatisticsPeriod.values[i].label,
              selected: value == StatisticsPeriod.values[i],
              activeColor: Colors.white,
              onTap: () => onChanged(StatisticsPeriod.values[i]),
            ),
          ),
          if (i != StatisticsPeriod.values.length - 1) SizedBox(width: 10.w),
        ],
      ],
    );
  }
}

class _FilterSelector extends StatelessWidget {
  final StatisticsTaskFilter value;
  final ValueChanged<StatisticsTaskFilter> onChanged;

  const _FilterSelector({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < StatisticsTaskFilter.values.length; i++) ...[
          Expanded(
            child: _PillButton(
              label: StatisticsTaskFilter.values[i].label,
              selected: value == StatisticsTaskFilter.values[i],
              activeColor: StatisticsTaskFilter.values[i].color,
              inactiveColor: StatisticsTaskFilter.values[i].color.withOpacity(
                0.38,
              ),
              onTap: () => onChanged(StatisticsTaskFilter.values[i]),
            ),
          ),
          if (i != StatisticsTaskFilter.values.length - 1)
            SizedBox(width: 10.w),
        ],
      ],
    );
  }
}

class _PillButton extends StatelessWidget {
  final String label;
  final bool selected;
  final Color activeColor;
  final Color? inactiveColor;
  final VoidCallback onTap;

  const _PillButton({
    required this.label,
    required this.selected,
    required this.activeColor,
    this.inactiveColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final background = selected
        ? activeColor
        : (inactiveColor ?? Colors.white.withOpacity(0.12));
    final selectedTextColor = activeColor.computeLuminance() > 0.55
        ? black
        : white;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 13.h),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: context.subStyle.copyWith(
              color: selected
                  ? selectedTextColor
                  : Colors.white.withOpacity(0.96),
              fontWeight: FontWeight.w700,
              fontSize: 12.sp,
            ),
          ),
        ),
      ),
    );
  }
}

class _StatisticsChartCard extends StatelessWidget {
  final String title;
  final List<String> labels;
  final List<double> values;
  final Color color;
  final Color cardColor;
  final Color trackColor;
  final bool scrollable;

  const _StatisticsChartCard({
    required this.title,
    required this.labels,
    required this.values,
    required this.color,
    required this.cardColor,
    required this.trackColor,
    required this.scrollable,
  });

  @override
  Widget build(BuildContext context) {
    final total = values.fold<double>(0, (sum, value) => sum + value);

    return Container(
      padding: EdgeInsets.fromLTRB(14.w, 16.h, 14.w, 14.h),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: context.titleTextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                'Jami ${total.toInt()}',
                style: context.subStyle.copyWith(
                  color: Colors.white.withOpacity(0.88),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 270.h,
            child: _StatusBarChart(
              labels: labels,
              values: values,
              color: color,
              trackColor: trackColor,
              scrollable: scrollable,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBarChart extends StatelessWidget {
  final List<String> labels;
  final List<double> values;
  final Color color;
  final Color trackColor;
  final bool scrollable;

  const _StatusBarChart({
    required this.labels,
    required this.values,
    required this.color,
    required this.trackColor,
    required this.scrollable,
  });

  @override
  Widget build(BuildContext context) {
    final maxValue = values.fold<double>(0, math.max);
    final maxIndex = values.isEmpty
        ? -1
        : values.indexWhere((value) => value == maxValue);

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = scrollable
            ? math.max(58.w, constraints.maxWidth / 6)
            : constraints.maxWidth / math.max(1, values.length);
        final chartWidth = scrollable
            ? math.max(constraints.maxWidth, itemWidth * values.length)
            : constraints.maxWidth;

        final chart = SizedBox(
          width: chartWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (int i = 0; i < values.length; i++)
                SizedBox(
                  width: itemWidth,
                  child: _BarItem(
                    label: labels[i],
                    value: values[i],
                    maxValue: maxValue,
                    color: color,
                    trackColor: trackColor,
                    highlighted: i == maxIndex && values[i] > 0,
                  ),
                ),
            ],
          ),
        );

        if (!scrollable) return chart;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: chart,
        );
      },
    );
  }
}

class _BarItem extends StatelessWidget {
  final String label;
  final double value;
  final double maxValue;
  final Color color;
  final Color trackColor;
  final bool highlighted;

  const _BarItem({
    required this.label,
    required this.value,
    required this.maxValue,
    required this.color,
    required this.trackColor,
    required this.highlighted,
  });

  @override
  Widget build(BuildContext context) {
    const barAreaHeight = 150.0;
    final safeMax = math.max(1.0, maxValue);
    final normalized = (value / safeMax).clamp(0.0, 1.0);
    final barHeight = value <= 0
        ? 6.0
        : math.max(12.0, barAreaHeight * normalized);
    final barColor = highlighted ? color : color.withOpacity(0.85);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _ValueBadge(value: value),
          SizedBox(height: 8.h),
          Container(
            width: 44.w,
            height: barAreaHeight.h,
            decoration: BoxDecoration(
              color: trackColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              width: 44.w,
              height: barHeight.h,
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: context.subStyle.copyWith(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ValueBadge extends StatelessWidget {
  final double value;

  const _ValueBadge({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.32),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        value.toInt().toString(),
        style: context.subStyle.copyWith(
          color: Colors.white,
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _PercentCards extends StatelessWidget {
  final StatisticsTaskFilter selectedFilter;
  final double donePercent;
  final double latePercent;
  final double notDonePercent;

  const _PercentCards({
    required this.selectedFilter,
    required this.donePercent,
    required this.latePercent,
    required this.notDonePercent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: _PercentCardItem(
              title: '${donePercent.toStringAsFixed(0)}%',
              subtitle: StatisticsTaskFilter.done.label,
              color: StatisticsTaskFilter.done.color,
              selected: selectedFilter == StatisticsTaskFilter.done,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _PercentCardItem(
              title: '${latePercent.toStringAsFixed(0)}%',
              subtitle: StatisticsTaskFilter.late.label,
              color: StatisticsTaskFilter.late.color,
              selected: selectedFilter == StatisticsTaskFilter.late,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _PercentCardItem(
              title: '${notDonePercent.toStringAsFixed(0)}%',
              subtitle: StatisticsTaskFilter.notDone.label,
              color: StatisticsTaskFilter.notDone.color,
              selected: selectedFilter == StatisticsTaskFilter.notDone,
            ),
          ),
        ],
      ),
    );
  }
}

class _PercentCardItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final bool selected;

  const _PercentCardItem({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: selected ? color.withOpacity(0.20) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: selected ? color : Colors.grey.withOpacity(0.24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.titleTextStyle.copyWith(
              fontSize: 28.sp,
              color: black,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            subtitle,
            style: context.subStyle.copyWith(
              color: black.withOpacity(0.74),
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _Bucket {
  final DateTime start;
  final DateTime endExclusive;
  final String label;

  const _Bucket({
    required this.start,
    required this.endExclusive,
    required this.label,
  });
}

class _SeriesData {
  final List<double> done;
  final List<double> late;
  final List<double> notDone;

  const _SeriesData({
    required this.done,
    required this.late,
    required this.notDone,
  });
}

class _Totals {
  final int done;
  final int late;
  final int notDone;

  const _Totals({
    required this.done,
    required this.late,
    required this.notDone,
  });

  int get all => done + late + notDone;
}

class _Percents {
  final double done;
  final double late;
  final double notDone;

  const _Percents({
    required this.done,
    required this.late,
    required this.notDone,
  });
}

List<_Bucket> _buildBuckets(
  StatisticsPeriod period,
  List<TodoDayModel> days,
  DateTime today,
) {
  final locale = AppStorage.appLocale;
  final weekLabelFormat = DateFormat('E', locale);
  final monthFormat = DateFormat.MMM(locale);

  switch (period) {
    case StatisticsPeriod.weekly:
      final weekStart = today.subtract(Duration(days: today.weekday - 1));
      return List.generate(7, (index) {
        final day = weekStart.add(Duration(days: index));
        return _Bucket(
          start: day,
          endExclusive: day.add(const Duration(days: 1)),
          label: '${weekLabelFormat.format(day)}\n${day.day}',
        );
      });

    case StatisticsPeriod.monthly:
      return List.generate(12, (index) {
        final monthStart = DateTime(today.year, index + 1, 1);
        final nextMonth = DateTime(today.year, index + 2, 1);
        return _Bucket(
          start: monthStart,
          endExclusive: nextMonth,
          label: monthFormat.format(monthStart),
        );
      });

    case StatisticsPeriod.yearly:
      final firstYear = _firstDataYear(days, today.year);
      final yearCount = today.year - firstYear + 1;
      return List.generate(yearCount, (index) {
        final yearStart = DateTime(firstYear + index, 1, 1);
        final nextYear = DateTime(firstYear + index + 1, 1, 1);
        return _Bucket(
          start: yearStart,
          endExclusive: nextYear,
          label: '${yearStart.year}',
        );
      });
  }
}

int _firstDataYear(List<TodoDayModel> days, int fallbackYear) {
  var minYear = fallbackYear;

  for (final day in days) {
    if (day.date.year < minYear) {
      minYear = day.date.year;
    }

    for (final task in day.tasks) {
      if (task.plannedAt.year < minYear) {
        minYear = task.plannedAt.year;
      }
    }
  }

  return minYear;
}

_SeriesData _buildSeries(List<TodoDayModel> days, List<_Bucket> buckets) {
  final dayMap = <DateTime, TodoDayModel>{
    for (final day in days) TodoHelper.onlyDate(day.date): day,
  };

  final done = <double>[];
  final late = <double>[];
  final notDone = <double>[];

  for (final bucket in buckets) {
    int doneCount = 0;
    int lateCount = 0;
    int notDoneCount = 0;

    var cursor = TodoHelper.onlyDate(bucket.start);
    while (cursor.isBefore(bucket.endExclusive)) {
      final day = dayMap[cursor];
      if (day != null) {
        for (final task in day.tasks) {
          switch (TodoHelper.statusForTask(task, cursor)) {
            case TodoStatus.doneOnTime:
              doneCount++;
              break;
            case TodoStatus.late:
              lateCount++;
              break;
            case TodoStatus.notDone:
              notDoneCount++;
              break;
            case TodoStatus.pending:
              break;
          }
        }
      }
      cursor = cursor.add(const Duration(days: 1));
    }

    done.add(doneCount.toDouble());
    late.add(lateCount.toDouble());
    notDone.add(notDoneCount.toDouble());
  }

  return _SeriesData(done: done, late: late, notDone: notDone);
}

List<double> _valuesByFilter(_SeriesData series, StatisticsTaskFilter filter) {
  return switch (filter) {
    StatisticsTaskFilter.done => series.done,
    StatisticsTaskFilter.late => series.late,
    StatisticsTaskFilter.notDone => series.notDone,
  };
}

_Totals _totals(_SeriesData series) {
  int sum(List<double> values) {
    return values.fold(0, (total, value) => total + value.toInt());
  }

  return _Totals(
    done: sum(series.done),
    late: sum(series.late),
    notDone: sum(series.notDone),
  );
}

_Percents _toPercents(_Totals totals) {
  if (totals.all == 0) {
    return const _Percents(done: 0, late: 0, notDone: 0);
  }

  return _Percents(
    done: (totals.done * 100) / totals.all,
    late: (totals.late * 100) / totals.all,
    notDone: (totals.notDone * 100) / totals.all,
  );
}
