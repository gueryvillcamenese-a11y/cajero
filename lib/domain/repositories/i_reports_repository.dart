import 'package:cajero/domain/entities/shift_summary.dart';
import 'package:cajero/domain/entities/supervision_data.dart';

abstract class IReportsRepository {
  Future<ShiftSummary> getShiftSummary();
}

abstract class ISupervisionRepository {
  Future<SupervisionData> getSupervisionData();
}
