import 'package:cajero/domain/entities/shift_summary.dart';
import 'package:cajero/domain/repositories/i_reports_repository.dart';

class GetShiftSummaryUseCase {
  final IReportsRepository repository;

  GetShiftSummaryUseCase(this.repository);

  Future<ShiftSummary> execute() {
    return repository.getShiftSummary();
  }
}
