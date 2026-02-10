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

enum StatisticsRange { week, month1, month3, month6, year1 }

extension on StatisticsRange {
  String get label => switch (this) {
    StatisticsRange.week => '1 hafta',
    StatisticsRange.month1 => '1 oy',
    StatisticsRange.month3 => '3 oy',
    StatisticsRange.month6 => '6 oy',
    StatisticsRange.year1 => '1 yil',
  };
}

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  // static const _bg = Color(0xFF07152B);
  // static const _cardTop = Color(0xFF0B1D3A);
  // static const _cardBottom = Color(0xFF07152B);
  static const _blue = Color(0xFF4C7BF4);
  static const _pink = Color(0xFFFF4D6D);

  StatisticsRange _range = StatisticsRange.month3;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, todoState) {
        final endExclusive = TodoHelper.onlyDate(
          DateTime.now(),
        ).add(const Duration(days: 1));
        final buckets = _buildBuckets(_range, endExclusive);
        final series = _buildSeries(todoState.days, buckets);

        return CustomScaffold(
          withBackGround: false,
          backgroundColor: Colors.transparent,
          title: 'Dashboard',
          // scaffoldColor: _bg,
          // showBackgroundDecorations: false,
          // bodyColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.only(
              left: 4.w,
              right: 4.w,
              // top:
              //     MediaQuery.paddingOf(context).top +
              //     kToolbarHeight +
              //     spacingVal.h,
              bottom: spacingVal.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _RangeSelector(
                  value: _range,
                  onChanged: (next) => setState(() => _range = next),
                ),
                SizedBox(height: 18.h),
                Expanded(
                  child: _ChartShell(
                    labels: buckets.map((b) => b.label).toList(),
                    totalValues: series.total,
                    doneValues: series.done,
                    totalColor: _blue,
                    doneColor: _pink,
                    cardTop: white.withOpacity(0.2),
                    cardBottom: context.secondaryColor.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RangeSelector extends StatelessWidget {
  final StatisticsRange value;
  final ValueChanged<StatisticsRange> onChanged;

  const _RangeSelector({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final items = StatisticsRange.values;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          for (final item in items) ...[
            _RangeChip(
              label: item.label,
              selected: item == value,
              onTap: () => onChanged(item),
            ),
            SizedBox(width: 10.w),
          ],
        ],
      ),
    );
  }
}

class _RangeChip extends StatelessWidget {
  static const _accent = Color(0xFFFF4D6D);

  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _RangeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? _accent : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: context.subStyle.copyWith(
            fontSize: 13.sp,
            color: selected ? Colors.white : Colors.white.withOpacity(0.72),
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
      ),
    );
  }
}

class _ChartShell extends StatelessWidget {
  final List<String> labels;
  final List<double> totalValues;
  final List<double> doneValues;
  final Color totalColor;
  final Color doneColor;
  final Color cardTop;
  final Color cardBottom;

  const _ChartShell({
    required this.labels,
    required this.totalValues,
    required this.doneValues,
    required this.totalColor,
    required this.doneColor,
    required this.cardTop,
    required this.cardBottom,
  });

  @override
  Widget build(BuildContext context) {
    final isEmpty =
        totalValues.every((v) => v == 0) && doneValues.every((v) => v == 0);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [cardTop, cardBottom],
        ),
        borderRadius: BorderRadius.circular(26.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26.r),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 14.h),
              child: Column(
                children: [
                  Expanded(
                    child: isEmpty
                        ? Center(
                            child: Text(
                              'Ma\'lumot yo\'q',
                              style: context.subStyle.copyWith(
                                color: Colors.white.withOpacity(0.70),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        : _DualLineChart(
                            totalValues: totalValues,
                            doneValues: doneValues,
                            totalColor: totalColor,
                            doneColor: doneColor,
                          ),
                  ),
                  SizedBox(height: 10.h),
                  _XAxisLabels(labels: labels),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DualLineChart extends StatelessWidget {
  final List<double> totalValues;
  final List<double> doneValues;
  final Color totalColor;
  final Color doneColor;

  const _DualLineChart({
    required this.totalValues,
    required this.doneValues,
    required this.totalColor,
    required this.doneColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: _DualLineChartPainter(
            totalValues: totalValues,
            doneValues: doneValues,
            totalColor: totalColor,
            doneColor: doneColor,
          ),
        );
      },
    );
  }
}

class _DualLineChartPainter extends CustomPainter {
  final List<double> totalValues;
  final List<double> doneValues;
  final Color totalColor;
  final Color doneColor;

  const _DualLineChartPainter({
    required this.totalValues,
    required this.doneValues,
    required this.totalColor,
    required this.doneColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (totalValues.isEmpty || doneValues.isEmpty) return;
    final count = math.min(totalValues.length, doneValues.length);
    if (count <= 1) return;

    const leftPad = 8.0;
    const rightPad = 8.0;
    const topPad = 10.0;
    const bottomPad = 10.0;

    final chartWidth = math.max(0.0, size.width - leftPad - rightPad);
    final chartHeight = math.max(0.0, size.height - topPad - bottomPad);

    final maxTotal = totalValues
        .take(count)
        .fold<double>(0, (m, v) => math.max(m, v));
    final maxDone = doneValues
        .take(count)
        .fold<double>(0, (m, v) => math.max(m, v));
    final safeMax = math.max(1.0, math.max(maxTotal, maxDone));

    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 1;

    for (int i = 0; i < 4; i++) {
      final y = topPad + (chartHeight / 3) * i;
      canvas.drawLine(
        Offset(leftPad, y),
        Offset(leftPad + chartWidth, y),
        gridPaint,
      );
    }

    final segment = chartWidth / (count - 1);
    final verticalEvery = count <= 12
        ? 1
        : count <= 20
        ? 2
        : count <= 31
        ? 3
        : 6;
    for (int i = 0; i < count; i++) {
      if (i % verticalEvery != 0 && i != count - 1) continue;
      final x = leftPad + segment * i;
      canvas.drawLine(
        Offset(x, topPad),
        Offset(x, topPad + chartHeight),
        gridPaint,
      );
    }

    final totalPoints = _pointsFor(
      totalValues.take(count).toList(growable: false),
      leftPad,
      topPad,
      chartWidth,
      chartHeight,
      safeMax,
    );
    final donePoints = _pointsFor(
      doneValues.take(count).toList(growable: false),
      leftPad,
      topPad,
      chartWidth,
      chartHeight,
      safeMax,
    );

    _drawSeries(canvas, size, totalPoints, totalColor);
    _drawSeries(canvas, size, donePoints, doneColor, highlightLast: true);
  }

  List<Offset> _pointsFor(
    List<double> values,
    double leftPad,
    double topPad,
    double chartWidth,
    double chartHeight,
    double safeMax,
  ) {
    final count = values.length;
    final segment = count == 1 ? 0.0 : chartWidth / (count - 1);
    final points = <Offset>[];
    for (int i = 0; i < count; i++) {
      final normalized = (values[i] / safeMax).clamp(0.0, 1.0);
      final x = leftPad + segment * i;
      final y = topPad + chartHeight - (chartHeight * normalized);
      points.add(Offset(x, y));
    }
    return points;
  }

  void _drawSeries(
    Canvas canvas,
    Size size,
    List<Offset> points,
    Color color, {
    bool highlightLast = false,
  }) {
    if (points.length < 2) return;

    final strokePath = _smoothPath(points);

    final fillPath = Path()
      ..addPath(strokePath, Offset.zero)
      ..lineTo(points.last.dx, size.height)
      ..lineTo(points.first.dx, size.height)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withOpacity(0.18), color.withOpacity(0.00)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
    canvas.drawPath(fillPath, fillPaint);

    final glowPaint = Paint()
      ..color = color.withOpacity(0.25)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawPath(strokePath, glowPaint);

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(strokePath, linePaint);

    final dotEvery = points.length <= 24 ? 1 : (points.length / 24).ceil();
    final dotPaint = Paint()..color = Colors.white.withOpacity(0.85);
    for (int i = 0; i < points.length; i += dotEvery) {
      canvas.drawCircle(points[i], 2.4, dotPaint);
    }

    if (highlightLast) {
      final p = points.last;
      canvas.drawCircle(
        p,
        7.0,
        Paint()..color = Colors.white.withOpacity(0.15),
      );
      canvas.drawCircle(
        p,
        5.2,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
      canvas.drawCircle(p, 3.2, Paint()..color = color);
    }
  }

  Path _smoothPath(List<Offset> points) {
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    if (points.length == 2) {
      path.lineTo(points.last.dx, points.last.dy);
      return path;
    }

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = i == 0 ? points[i] : points[i - 1];
      final p1 = points[i];
      final p2 = points[i + 1];
      final p3 = i + 2 < points.length ? points[i + 2] : p2;

      final cp1 = Offset(
        p1.dx + (p2.dx - p0.dx) / 6,
        p1.dy + (p2.dy - p0.dy) / 6,
      );
      final cp2 = Offset(
        p2.dx - (p3.dx - p1.dx) / 6,
        p2.dy - (p3.dy - p1.dy) / 6,
      );
      path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p2.dx, p2.dy);
    }
    return path;
  }

  @override
  bool shouldRepaint(covariant _DualLineChartPainter oldDelegate) {
    return oldDelegate.totalValues != totalValues ||
        oldDelegate.doneValues != doneValues ||
        oldDelegate.totalColor != totalColor ||
        oldDelegate.doneColor != doneColor;
  }
}

class _XAxisLabels extends StatelessWidget {
  final List<String> labels;

  const _XAxisLabels({required this.labels});

  @override
  Widget build(BuildContext context) {
    if (labels.isEmpty) return const SizedBox.shrink();

    final showEvery = labels.length <= 12
        ? 1
        : labels.length <= 20
        ? 2
        : labels.length <= 31
        ? 3
        : 6;

    return Row(
      children: List.generate(labels.length, (index) {
        final show =
            index == 0 ||
            index == labels.length - 1 ||
            (index % showEvery == 0);
        return Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              show ? labels[index] : '',
              style: context.subStyle.copyWith(
                fontSize: 10.sp,
                color: Colors.white.withOpacity(0.55),
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
        );
      }),
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

List<_Bucket> _buildBuckets(StatisticsRange range, DateTime endExclusive) {
  final locale = AppStorage.appLocale;
  final dayFormat = DateFormat.Md(locale);
  final monthFormat = DateFormat.MMM(locale);

  switch (range) {
    case StatisticsRange.week:
      final start = endExclusive.subtract(const Duration(days: 7));
      return List.generate(7, (i) {
        final d = start.add(Duration(days: i));
        return _Bucket(
          start: d,
          endExclusive: d.add(const Duration(days: 1)),
          label: dayFormat.format(d),
        );
      });
    case StatisticsRange.month1:
      final start = endExclusive.subtract(const Duration(days: 30));
      return _weeklyBuckets(start, endExclusive, dayFormat);
    case StatisticsRange.month3:
      final start = endExclusive.subtract(const Duration(days: 90));
      return _weeklyBuckets(start, endExclusive, dayFormat);
    case StatisticsRange.month6:
      return _monthBuckets(6, endExclusive, monthFormat);
    case StatisticsRange.year1:
      return _monthBuckets(12, endExclusive, monthFormat);
  }
}

List<_Bucket> _weeklyBuckets(
  DateTime start,
  DateTime endExclusive,
  DateFormat labelFormat,
) {
  final buckets = <_Bucket>[];
  var cursor = start;
  while (cursor.isBefore(endExclusive)) {
    final next = cursor.add(const Duration(days: 7));
    final bucketEnd = next.isBefore(endExclusive) ? next : endExclusive;
    buckets.add(
      _Bucket(
        start: cursor,
        endExclusive: bucketEnd,
        label: labelFormat.format(cursor),
      ),
    );
    cursor = bucketEnd;
  }
  return buckets;
}

List<_Bucket> _monthBuckets(
  int monthCount,
  DateTime endExclusive,
  DateFormat monthFormat,
) {
  final endDay = endExclusive.subtract(const Duration(days: 1));
  final firstMonth = DateTime(endDay.year, endDay.month - (monthCount - 1), 1);
  final buckets = <_Bucket>[];

  for (int i = 0; i < monthCount; i++) {
    final monthStart = DateTime(firstMonth.year, firstMonth.month + i, 1);
    final nextMonth = DateTime(monthStart.year, monthStart.month + 1, 1);
    final bucketEnd = i == monthCount - 1 ? endExclusive : nextMonth;
    buckets.add(
      _Bucket(
        start: monthStart,
        endExclusive: bucketEnd,
        label: monthFormat.format(monthStart),
      ),
    );
  }

  return buckets;
}

({List<double> total, List<double> done}) _buildSeries(
  List<TodoDayModel> days,
  List<_Bucket> buckets,
) {
  final dayMap = <DateTime, TodoDayModel>{
    for (final d in days) TodoHelper.onlyDate(d.date): d,
  };

  final totals = <double>[];
  final dones = <double>[];

  for (final bucket in buckets) {
    int total = 0;
    int done = 0;
    var cursor = TodoHelper.onlyDate(bucket.start);
    while (cursor.isBefore(bucket.endExclusive)) {
      final day = dayMap[cursor];
      if (day != null) {
        total += day.tasks.length;
        done += day.tasks.where((t) => t.isDone).length;
      }
      cursor = cursor.add(const Duration(days: 1));
    }
    totals.add(total.toDouble());
    dones.add(done.toDouble());
  }

  return (total: totals, done: dones);
}
