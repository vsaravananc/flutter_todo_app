
import 'package:todoapp/core/enum/task_enum.dart';

extension TaskExtension on TaskEnum {
  String get uiName => switch (this) {
    TaskEnum.Completed => "Completed",
    TaskEnum.Pending => "Pending",
  };
}