import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
        child: Icon(
          key: const ValueKey('date_icon_holder'),
          Icons.calendar_today_sharp,
          size: 20,
          color: Theme.of(context).colorScheme.secondary,
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
  final DateRangePickerController dateController = DateRangePickerController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SfDateRangePicker(
              controller: dateController,
              showNavigationArrow: true,
              initialDisplayDate: DateTime.now(),
              initialSelectedDate: DateTime.now(),
             
              headerStyle: DateRangePickerHeaderStyle(
                backgroundColor: Theme.of(context).cardColor,
                textAlign: TextAlign.center,
              ),
              monthViewSettings: DateRangePickerMonthViewSettings(
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  backgroundColor: Theme.of(context).cardColor,
                ),
              ),

              backgroundColor: Theme.of(context).cardColor,
              minDate: DateTime.now(),
              maxDate: DateTime.now().add(const Duration(days: 365)),
              selectionColor: Theme.of(context).colorScheme.primary,
              showTodayButton: false,
              showActionButtons: false,
              
              confirmText: "SELECT",
              onCancel: () => Navigator.pop(context),
              view: DateRangePickerView.month,


            ),
          ],
        ),
      ),
    );
  }
}
