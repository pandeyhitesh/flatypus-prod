import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flatypus/core/theme/app_colors.dart';
import 'package:flatypus/core/theme/borders.dart';
import 'package:flatypus/core/utils/methods.dart';
import 'package:flatypus/features/common/controllers/display_tasks_date_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomCalendarTimeline extends ConsumerStatefulWidget {
  const CustomCalendarTimeline({
    super.key,
    required this.timelineCalendarController,
  });
  final DatePickerController timelineCalendarController;

  @override
  ConsumerState<CustomCalendarTimeline> createState() =>
      _CustomCalendarTimelineState();
}

class _CustomCalendarTimelineState
    extends ConsumerState<CustomCalendarTimeline> {
  late DatePickerController _dateController;

  DateTime get _startDate =>
      DateTime(today.year, today.month, 1).subtract(const Duration(days: 30));

  @override
  void initState() {
    super.initState();
    _dateController = widget.timelineCalendarController;
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    // });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(displayTasksSelectedDateProvider, (previous, next) {
      if (previous != next && next != null) {
        _dateController.setDateAndAnimate(next);
      }
    });
    return SizedBox(
      width: kScreenWidth,
      child: Container(
        decoration: customCardDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              DatePicker(
                _startDate,
                controller: _dateController,
                initialSelectedDate: today,
                selectionColor: AppColors.yellowAccent,
                selectedTextColor: AppColors.white,
                daysCount: 60,
                height: 80,
                width: 50,
                monthTextStyle: TextStyle(
                  fontSize: 10,
                  color: AppColors.white.withAlpha(200),
                ),
                dateTextStyle: TextStyle(
                  fontSize: 20,
                  color: AppColors.white.withAlpha(230),
                ),
                dayTextStyle: TextStyle(
                  fontSize: 10,
                  color: AppColors.white.withAlpha(200),
                ),
                calendarType: CalendarType.gregorianDate,
                onDateChange:
                    (date) =>
                        ref
                            .read(displayTasksSelectedDateProvider.notifier)
                            .state = date,
              ),
              // Positioned(
              //   right: 0,
              //   child: GestureDetector(
              //     onTap: () {
              //       _dateController.animateToDate(today);
              //     },
              //     child: Container(
              //       height: 80,
              //       width: 50,
              //       decoration: customCardDecoration(
              //           bgColor: AppColors.secondaryColor.withAlpha(240),
              //           borderColor: AppColors.white,
              //           borderWidth: 2),
              //       child: const Center(
              //         child: Text(
              //           'Scroll\nto\nToday',
              //           overflow: TextOverflow.fade,
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //               fontSize: 12,
              //               color: AppColors.white,
              //               fontWeight: FontWeight.w500),
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
          // child: CalendarTimeline(
          //   initialDate: today,
          //   firstDate: _startDate,
          //   lastDate: _endDate,
          //   onDateSelected: (date) {},
          //   leftMargin: 0,
          //   monthColor: AppColors.white,
          //   dayColor: Colors.white70,
          //   activeDayColor: Colors.white,
          //   activeBackgroundDayColor: AppColors.yellowAccent,
          //   dotColor: Colors.white,
          //   dayNameColor: Colors.white60,
          //   locale: 'en',
          //   shrink: true,
          //   shrinkWidth: 40,
          //   shrinkFontSize: 18,
          // ),
        ),
      ),
      // child: TimelineCalendar(
      //   calendarType: CalendarType.GREGORIAN,
      //   calendarLanguage: "en",
      //   calendarOptions: CalendarOptions(
      //     viewType: ViewType.DAILY,
      //     toggleViewType: true,
      //     headerMonthElevation: 0,
      //     headerMonthShadowColor: Colors.transparent,
      //     headerMonthBackColor: Colors.transparent,
      //     bottomSheetBackColor: Colors.black38,
      //     headerMonthShape:
      //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
      //   ),
      //   dayOptions: DayOptions(
      //     compactMode: true,
      //     weekDaySelectedColor: AppColors.yellowAccent,
      //     disableDaysBeforeNow: false,
      //     selectedBackgroundColor: AppColors.yellowAccent,
      //     showWeekDay: true,
      //   ),
      //   headerOptions: HeaderOptions(
      //       weekDayStringType: WeekDayStringTypes.SHORT,
      //       monthStringType: MonthStringTypes.FULL,
      //       backgroundColor: AppColors.secondaryColor,
      //       headerTextColor: AppColors.white,
      //       calendarIconColor: AppColors.white,
      //       navigationColor: AppColors.white,
      //       resetDateColor: AppColors.white,
      //       headerTextSize: 18),
      //   onChangeDateTime: (datetime) {
      //     print(datetime.getDate());
      //   },
      // ),
    );
  }
}
