import 'package:flutter/material.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/responsive_size.dart';

class CustomCalendar extends StatefulWidget {
  final DateTime? initialDate; // Boshlang'ich tanlangan sana
  final DateTime? minDate; // Eng kichik ruxsat berilgan sana
  final DateTime? maxDate; // Eng katta ruxsat berilgan sana
  final ValueChanged<DateTime>? onDateSelected;
  final Color? primaryColor; // Tanlangan sana rangi
  final Color? todayColor; // Bugungi sana konturi
  final bool showWeekDays; // Hafta kunlari headerini ko‘rsatish
  final Color? Function(DateTime day)? dayMarkerColorBuilder;
  final Color? Function(DateTime day)? dayBackgroundColorBuilder;

  const CustomCalendar({
    super.key,
    this.initialDate,
    this.minDate,
    this.maxDate,
    this.onDateSelected,
    this.primaryColor,
    this.todayColor,
    this.showWeekDays = true,
    this.dayMarkerColorBuilder,
    this.dayBackgroundColorBuilder,
  });

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime _visibleMonth; // Hozir ko'rinayotgan oy (1-kuni)
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = widget.initialDate;
    _visibleMonth = DateTime(
      (_selectedDate ?? now).year,
      (_selectedDate ?? now).month,
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = widget.primaryColor ?? theme.colorScheme.primary;
    final todayBorder = widget.todayColor ?? theme.colorScheme.primary;

    return Column(
      children: [
        _buildHeader(primary),
        SizedBox(height: 8.h),
        if (widget.showWeekDays) _buildWeekDaysRow(theme),
        SizedBox(height: 5.h),
        _buildDaysGrid(primary, todayBorder, theme),
      ],
    );
  }

  /// Yuqori qism: oy nomi + oldingi/kelgusi oy tugmalari
  Widget _buildHeader(Color primary) {
    final monthName = _monthNameUz(_visibleMonth.month);
    final year = _visibleMonth.year;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: _goToPrevMonth,
          icon: Icon(Icons.chevron_left, size: 30.h),
        ),
        Text(
          '$monthName $year',
          style: TextStyle(
            fontSize: 18.sp,
            color: black,
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: _goToNextMonth,
          icon: Icon(Icons.chevron_right, size: 30.h),
        ),
      ],
    );
  }

  /// Hafta kunlari (Du, Se, Ch, ...)
  Widget _buildWeekDaysRow(ThemeData theme) {
    const days = ['Du', 'Se', 'Ch', 'Pa', 'Ju', 'Sh', 'Ya'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days
          .map(
            (d) => Expanded(
              child: Center(
                child: Text(
                  d,
                  style: theme.textTheme.labelMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  /// Asosiy kunlar tarmog'i
  Widget _buildDaysGrid(Color primary, Color todayBorder, ThemeData theme) {
    final days = _generateDaysForMonth(_visibleMonth);

    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: days.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 4.h / 1.w,
        crossAxisSpacing: 4.h / 1.w,
        childAspectRatio: 1.45.w / 1.h,
      ),
      itemBuilder: (context, index) {
        final day = days[index];

        if (day == null) {
          // Bo'sh katak
          return const SizedBox.shrink();
        }

        final isDisabled = _isDisabled(day);
        final isSelected =
            _selectedDate != null && _isSameDate(_selectedDate!, day);
        final isToday = _isSameDate(DateTime.now(), day);

        Color bg = Colors.transparent;
        Color textColor = isDisabled
            ? theme.disabledColor
            : theme.textTheme.bodyMedium!.color ?? Colors.black;
        final bgColor = widget.dayBackgroundColorBuilder?.call(day);
        final markerColor = widget.dayMarkerColorBuilder?.call(day);

        BoxBorder? border;
        if (isToday && !isSelected) {
          border = Border.all(color: todayBorder, width: 1.4.r);
        }
        if (isSelected) {
          bg = primary;
          textColor = Colors.white;
        } else if (bgColor != null) {
          bg = bgColor.withOpacity(0.18);
        }

        return GestureDetector(
          onTap: isDisabled
              ? null
              : () {
                  setState(() {
                    _selectedDate = day;
                  });
                  widget.onDateSelected?.call(day);
                },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            // padding: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: bg,
              border: border,
              borderRadius: BorderRadius.circular(10.r),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${day.day}',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: textColor,
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                if (markerColor != null)
                  Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Container(
                      width: 16.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: markerColor,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Ko'rinayotgan oy uchun barcha kataklarni hisoblash
  List<DateTime?> _generateDaysForMonth(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final firstWeekday = firstDayOfMonth.weekday; // 1=Du ... 7=Ya

    // Oy oxiri: keyingi oyning 0-kuni — 100% to‘g‘ri usul
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;

    // Grid boshida nechta bo'sh katak kerak (hafta Du bilan boshlanadi)
    final leadingEmpty = (firstWeekday - 1); // Du=1 => 0 ta bo'sh

    final totalCells = leadingEmpty + daysInMonth;
    // Haftalar to'liq bo'lishi uchun 7 ga bo'linadigan qilamiz
    final rows = (totalCells / 7).ceil();
    final gridItemCount = rows * 7;

    final List<DateTime?> cells = List.filled(gridItemCount, null);

    for (int i = 0; i < daysInMonth; i++) {
      cells[leadingEmpty + i] = DateTime(month.year, month.month, i + 1);
    }

    return cells;
  }

  bool _isDisabled(DateTime day) {
    if (widget.minDate != null && day.isBefore(_onlyDate(widget.minDate!))) {
      return true;
    }
    if (widget.maxDate != null && day.isAfter(_onlyDate(widget.maxDate!))) {
      return true;
    }
    return false;
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  DateTime _onlyDate(DateTime d) => DateTime(d.year, d.month, d.day);

  void _goToPrevMonth() {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month - 1, 1);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + 1, 1);
    });
  }

  String _monthNameUz(int month) {
    switch (month) {
      case 1:
        return 'Yanvar';
      case 2:
        return 'Fevral';
      case 3:
        return 'Mart';
      case 4:
        return 'Aprel';
      case 5:
        return 'May';
      case 6:
        return 'Iyun';
      case 7:
        return 'Iyul';
      case 8:
        return 'Avgust';
      case 9:
        return 'Sentabr';
      case 10:
        return 'Oktabr';
      case 11:
        return 'Noyabr';
      case 12:
        return 'Dekabr';
      default:
        return '';
    }
  }
}
