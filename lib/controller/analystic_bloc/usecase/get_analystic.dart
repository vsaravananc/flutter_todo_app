import 'package:either_dart/either.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/controller/analystic_bloc/model/analystic_model.dart';
import 'package:todoapp/features/analytics/model/pie_chart_model.dart';

typedef Getanalysticdata = Future<Either<AnalysticModel, String>>;

abstract class GetAnalysticRepo {
  Getanalysticdata getanalysticdata();
}

class GetAnalysticUseCase implements GetAnalysticRepo {
  final Database database;

  const GetAnalysticUseCase({required this.database});

  @override
  Getanalysticdata getanalysticdata() async {
    try {
      final result = await database.transaction<AnalysticModel>((txn) async {
        final totalTask = await txn.query('todos');
        final completeTask = await txn.query(
          'todos',
          where: 'isDone = ?',
          whereArgs: [1],
        );
        return AnalysticModel(
          completedTask: completeTask.length,
          pendingTask: totalTask.length - completeTask.length,
          pieChartModel: const PieChartModel(listOfPieChartValue: []),
        );
      });
      return Left(result);
    } catch (e) {
      return const Right("Failed");
    }
  }
}
