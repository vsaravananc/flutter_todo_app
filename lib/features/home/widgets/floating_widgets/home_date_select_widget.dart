import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeDateSelectWidget extends StatelessWidget {
  const HomeDateSelectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        key: const ValueKey('date_icon'),
        onTap: () async {
          await delayforSecond();
          if (context.mounted) triggerDilog(context);
        },
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedCalendar04,
          size: 30,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Future<void> delayforSecond() async {
    FocusManager.instance.primaryFocus?.unfocus();
    await Future.delayed(const Duration(milliseconds: 380));
  }

  void triggerDilog(context) {
    showDialog(
      context: context,
      builder: (c) => const TriggerDilog(key: ValueKey('trigger_date_picker')),
    );
  }
}

class TriggerDilog extends StatefulWidget {
  const TriggerDilog({super.key});

  @override
  State<TriggerDilog> createState() => _TriggerDilogState();
}

class _TriggerDilogState extends State<TriggerDilog> {
  final ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());

  @override
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder(
              valueListenable: selectedDate,
              builder: (context, value, child) {
                return TableCalendar(
                  currentDay: value,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronIcon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 15,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    rightChevronIcon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(const Duration(days: 365)),
                  focusedDay: selectedDate.value,
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                    weekendStyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    selectedDate.value = selectedDay;
                  },
                );
              },
            ),
            Text(
              "Coming Soon",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
